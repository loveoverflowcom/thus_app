import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_contacts/thus_contacts.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';

final class RepositoriesInjector extends HookWidget {
  const RepositoriesInjector({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final logger = useMemoized(() => const AppLogger());

    final httpClient = useMemoized(
      () => buildHttpClient(logger: logger),
    );

    final hiveInitializer = useMemoized(() => HiveInitializer(logger: logger));

    // Initialize Hive once
    final hiveReady = useState(false);
    useEffect(() {
      getApplicationSupportDirectory().then((dir) async {
        await hiveInitializer.init(storagePath: dir.path);
        hiveReady.value = true;
      });
      return null;
    }, []);

    final cacheFactory = useMemoized(
      () => CacheRepositoryFactory(hiveInitializer),
    );

    final restClient = useMemoized(
      () => RestClient(
        baseUrl: AppConstants.defaultApiBaseUrl,
        client: httpClient,
        logger: logger,
      ),
    );

    final sseClient = useMemoized(
      () => SseClient(
        baseUrl: AppConstants.defaultApiBaseUrl,
        client: httpClient,
        logger: logger,
      ),
    );

    final authLocalDataSource = useMemoized(
      () => AuthLocalDataSource(
        cacheFactory.box<AuthSession>(
          'auth_session',
          fromJson: AuthSession.fromJson,
          toJson: (s) => s.toJson(),
          encrypted: true,
        ),
      ),
    );

    final authRemoteDataSource = useMemoized(
      () => AuthRemoteDataSource(restClient: restClient, logger: logger),
    );

    final authRepository = useMemoized<AuthRepository>(
      () => AuthRepositoryImpl(
        localDataSource: authLocalDataSource,
        remoteDataSource: authRemoteDataSource,
      ),
    );

    final messageRepository = useMemoized<MessageRepository>(
      () => MessageRepositoryImpl(
        restClient: restClient,
        sseClient: sseClient,
        cache: cacheFactory.box<Message>(
          'messages',
          fromJson: Message.fromJson,
          toJson: (m) => m.toJson(),
        ),
        authRepository: authRepository,
        logger: logger,
      ),
    );

    final contactRepository = useMemoized<ContactRepository>(
      () => ContactRepositoryImpl(
        restClient: restClient,
        authRepository: authRepository,
      ),
    );

    useEffect(() {
      return messageRepository.dispose;
    }, [messageRepository]);

    if (!hiveReady.value) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<MessageRepository>.value(value: messageRepository),
        RepositoryProvider<ContactRepository>.value(value: contactRepository),
      ],
      child: child,
    );
  }
}
