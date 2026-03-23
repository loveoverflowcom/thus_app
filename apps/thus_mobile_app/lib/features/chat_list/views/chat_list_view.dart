import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';

final class ChatListView extends HookWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized(
      () => ChatListBloc(context.read<MessageRepository>()),
    );
    useEffect(() {
      bloc.add(const ChatListEvent.started());
      // Start SSE listening for incoming messages
      context.read<MessageRepository>().startListening().run();
      return bloc.close;
    }, []);

    return BlocProvider.value(
      value: bloc,
      child: const _ChatListContent(),
    );
  }
}

final class _ChatListContent extends HookWidget {
  const _ChatListContent();

  @override
  Widget build(BuildContext context) {
    final targetController = useTextEditingController();
    final targetError = useState<String?>(null);

    final authState = context.watch<AuthBloc>().state;
    final session = authState.session;
    final chatListBloc = context.read<ChatListBloc>();

    void openChat() {
      final peerUserId = targetController.text.trim();
      if (peerUserId.isEmpty) {
        targetError.value = 'Please enter a target user UUID.';
        return;
      }
      if (!isUuid(peerUserId)) {
        targetError.value = 'Target user id must be a UUID, not a username.';
        return;
      }
      targetError.value = null;
      context.push('/chat/$peerUserId').then(
            (_) => chatListBloc.add(const ChatListEvent.refreshed()),
          );
    }

    return BlocConsumer<ChatListBloc, ChatListState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status && curr.status.isFailure,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message ?? 'Something went wrong.')),
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(session?.username ?? 'Thus Chats'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current session',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text('user_id: ${session?.userId ?? '-'}'),
                      Text('username: ${session?.username ?? '-'}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: targetController,
                onChanged: (_) {
                  if (targetError.value != null) targetError.value = null;
                },
                decoration: InputDecoration(
                  labelText: 'Open chat by target user UUID',
                  hintText: 'e.g. 115cd206-5696-4eb0-92c0-00f6d9a99408',
                  helperText: 'The API expects user_id UUID, not username.',
                  errorText: targetError.value,
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: openChat,
                child: const Text('Open chat'),
              ),
              const SizedBox(height: 24),
              Text(
                'Cached conversations',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (state.status.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (state.chats.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'No cached chats yet. Send a message or receive one over SSE to populate this list.',
                  ),
                )
              else
                ...state.chats.map(
                  (chat) => Card(
                    child: ListTile(
                      title: Text(chat.title),
                      subtitle: Text(
                        chat.lastMessage?.content ?? 'No message',
                      ),
                      trailing: Text(
                        chat.updatedAt?.toLocal().toIso8601String() ?? '-',
                        textAlign: TextAlign.end,
                      ),
                      onTap: () => context
                          .push('/chat/${chat.id}')
                          .then((_) =>
                              chatListBloc.add(const ChatListEvent.refreshed())),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
