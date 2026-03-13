import 'package:get_it/get_it.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';

import '../data/message_repository.dart';
import '../data/message_repository_impl.dart';
import '../domain/entities/message.dart';
import '../domain/usecases/load_chat_history.dart';
import '../domain/usecases/receive_message.dart';
import '../domain/usecases/send_message.dart';
import '../domain/usecases/subscribe_chat_stream.dart';
import '../presentation/chat_bloc.dart';

Future<void> registerMessagingModule(GetIt getIt) async {
  getIt.registerLazySingleton<MessageRepository>(() {
    final cache = getIt<CacheRepositoryFactory>().box<Message>('messages', encrypted: false);
    return MessageRepositoryImpl(
      restClient: getIt<RestClient>(),
      socketFactory: (uri) => getIt<WebSocketClient>(param1: uri),
      cache: cache,
    );
  });

  getIt.registerFactory(() => SendMessage(getIt()));
  getIt.registerFactory(() => ReceiveMessage(getIt()));
  getIt.registerFactory(() => LoadChatHistory(getIt()));
  getIt.registerFactory(() => SubscribeChatStream(getIt()));
  getIt.registerFactory(() => ChatBloc(getIt(), getIt(), getIt()));
}
