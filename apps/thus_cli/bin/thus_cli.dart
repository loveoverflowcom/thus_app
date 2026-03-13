import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';
import 'package:thus_cli/src/cli.dart';
import 'package:thus_cli/src/commands/chats_command.dart';
import 'package:thus_cli/src/commands/login_command.dart';
import 'package:thus_cli/src/commands/send_command.dart';

final GetIt sl = GetIt.instance;

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureCoreDependencies();
  await registerStorageModule(sl);
  await registerNetworkModule(sl);
  await registerAuthModule(sl);
  await registerMessagingModule(sl);

  final cli = Cli([
    LoginCommand(sl<GenerateKeyPair>()),
    ChatsCommand(sl<LoadChatHistory>()),
    SendCommand(sl<SendMessage>(), sl<LoadIdentity>()),
  ]);

  await cli.run(args);
}
