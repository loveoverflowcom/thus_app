import 'package:get_it/get_it.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';

import '../data/message_repository.dart';
import '../data/message_repository_impl.dart';
import '../domain/entities/message.dart';
import '../presentation/chat_bloc.dart';

Future<void> registerMessagingModule(GetIt getIt) async {
  if (!getIt.isRegistered<MessageRepository>()) {
    getIt.registerLazySingleton<MessageRepository>(() {
      final CacheRepository<Message> cache = getIt<CacheRepositoryFactory>()
          .box<Message>(
            'messages',
            fromJson: Message.fromJson,
            toJson: (Message value) => value.toJson(),
          );

      return MessageRepositoryImpl(
        restClient: getIt<RestClient>(),
        sseClient: getIt<SseClient>(),
        cache: cache,
        authRepository: getIt<AuthRepository>(),
        logger: getIt<AppLogger>(),
      );
    });
  }

  getIt.registerFactory(() => ChatBloc(getIt<MessageRepository>()));
}
