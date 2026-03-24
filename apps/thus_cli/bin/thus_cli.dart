import 'dart:io';

import 'package:thus_auth/thus_auth.dart';
import 'package:thus_contacts/thus_contacts.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';
import 'package:thus_cli/src/cli.dart';
import 'package:thus_cli/src/commands/command_handler.dart';
import 'package:thus_cli/src/commands/chats_command.dart';
import 'package:thus_cli/src/commands/command_help.dart';
import 'package:thus_cli/src/commands/contacts_command.dart';
import 'package:thus_cli/src/commands/listen_command.dart';
import 'package:thus_cli/src/commands/login_command.dart';
import 'package:thus_cli/src/commands/logout_command.dart';
import 'package:thus_cli/src/commands/profile_command.dart';
import 'package:thus_cli/src/commands/register_command.dart';
import 'package:thus_cli/src/commands/send_command.dart';

const List<CommandHelp> _commandHelps = <CommandHelp>[
  RegisterCommand.helpInfo,
  LoginCommand.helpInfo,
  LogoutCommand.helpInfo,
  ProfileCommand.helpInfo,
  ContactsCommand.helpInfo,
  ChatsCommand.helpInfo,
  SendCommand.helpInfo,
  ListenCommand.helpInfo,
];

Future<void> main(List<String> args) async {
  final String? helpTarget = Cli.standaloneHelpTarget(args, _commandHelps);
  if (helpTarget != null) {
    if (helpTarget.isEmpty) {
      stdout.writeln(Cli.formatGeneralHelp(_commandHelps));
      return;
    }
    final CommandHelp commandHelp = _commandHelps.firstWhere(
      (CommandHelp help) => help.command == helpTarget,
    );
    stdout.writeln(commandHelp.formatDetails());
    return;
  }

  const logger = AppLogger();
  final httpClient = buildHttpClient(logger: logger);

  final String homeDirectory =
      Platform.environment['HOME'] ?? Directory.current.path;
  final hiveInitializer = HiveInitializer(logger: logger);
  await hiveInitializer.init(storagePath: '$homeDirectory/.thus_cli');

  final cacheFactory = CacheRepositoryFactory(hiveInitializer);
  final baseUrl = Platform.environment['THUS_BASE_URL'] ??
      AppConstants.defaultApiBaseUrl;

  final restClient = RestClient(
    baseUrl: baseUrl,
    client: httpClient,
    logger: logger,
  );
  final sseClient = SseClient(
    baseUrl: baseUrl,
    client: httpClient,
    logger: logger,
  );

  final authLocalDataSource = AuthLocalDataSource(
    cacheFactory.box<AuthSession>(
      'auth_session',
      fromJson: AuthSession.fromJson,
      toJson: (s) => s.toJson(),
      encrypted: true,
    ),
  );
  final authRemoteDataSource = AuthRemoteDataSource(
    restClient: restClient,
    logger: logger,
  );
  final AuthRepository authRepository = AuthRepositoryImpl(
    localDataSource: authLocalDataSource,
    remoteDataSource: authRemoteDataSource,
  );

  final ContactRepository contactRepository = ContactRepositoryImpl(
    restClient: restClient,
    authRepository: authRepository,
  );

  final MessageRepository messageRepository = MessageRepositoryImpl(
    restClient: restClient,
    sseClient: sseClient,
    cache: cacheFactory.box<Message>(
      'messages',
      fromJson: Message.fromJson,
      toJson: (m) => m.toJson(),
    ),
    authRepository: authRepository,
    logger: logger,
  );

  final Cli cli = Cli(<CommandHandler>[
    LoginCommand(authRepository),
    RegisterCommand(authRepository),
    LogoutCommand(authRepository),
    ProfileCommand(authRepository, contactRepository),
    ContactsCommand(authRepository, contactRepository),
    ChatsCommand(messageRepository),
    SendCommand(messageRepository, authRepository),
    ListenCommand(messageRepository),
  ]);

  await cli.run(args);
  messageRepository.dispose();
}
