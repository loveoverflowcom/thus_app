import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';
import 'package:thus_cli/src/cli.dart';
import 'package:thus_cli/src/commands/command_handler.dart';
import 'package:thus_cli/src/commands/chats_command.dart';
import 'package:thus_cli/src/commands/listen_command.dart';
import 'package:thus_cli/src/commands/login_command.dart';
import 'package:thus_cli/src/commands/logout_command.dart';
import 'package:thus_cli/src/commands/register_command.dart';
import 'package:thus_cli/src/commands/send_command.dart';

final GetIt sl = GetIt.instance;

Future<void> main(List<String> args) async {
  await configureCoreDependencies();
  await registerStorageModule(sl);

  final String homeDirectory =
      Platform.environment['HOME'] ?? Directory.current.path;
  await sl<HiveInitializer>().init(storagePath: '$homeDirectory/.thus_cli');

  await registerNetworkModule(
    sl,
    baseUrl:
        Platform.environment['THUS_BASE_URL'] ?? AppConstants.defaultApiBaseUrl,
  );
  await registerAuthModule(sl);
  await registerMessagingModule(sl);

  final Cli cli = Cli(<CommandHandler>[
    LoginCommand(sl<Login>()),
    RegisterCommand(sl<RegisterAccount>()),
    LogoutCommand(sl<Logout>()),
    ChatsCommand(sl<LoadChats>(), sl<LoadChatHistory>()),
    SendCommand(sl<SendMessage>(), sl<LoadSession>()),
    ListenCommand(sl<ReceiveMessage>()),
  ]);

  await cli.run(args);
}
