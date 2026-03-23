import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';

final class ChatView extends HookWidget {
  const ChatView({required this.conversationId, super.key});

  final String conversationId;

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized(
      () => ChatBloc(context.read<MessageRepository>()),
    );
    useEffect(() {
      bloc.add(ChatEvent.started(conversationId: conversationId));
      return bloc.close;
    }, []);

    return BlocProvider.value(
      value: bloc,
      child: _ChatContent(conversationId: conversationId),
    );
  }
}

final class _ChatContent extends HookWidget {
  const _ChatContent({required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context) {
    final messageController = useTextEditingController();

    void sendMessage() {
      final content = messageController.text.trim();
      if (content.isEmpty) return;

      final receiverId = conversationId.trim();
      if (!isUuid(receiverId)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Target user id must be a UUID, not a username.'),
          ),
        );
        return;
      }

      messageController.clear();
      context.read<ChatBloc>().add(
            ChatEvent.messageSent(
              receiverId: receiverId,
              content: content,
            ),
          );
    }

    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status && curr.status.isFailure,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message ?? 'Unable to send message.'),
          ),
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(conversationId)),
          body: Column(
            children: [
              Expanded(
                child: _buildMessageList(context, state),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: sendMessage,
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageList(BuildContext context, ChatState state) {
    if (state.status.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status.isFailure) {
      return Center(
        child: Text(state.message ?? 'Unable to load chat.'),
      );
    }

    if (state.messages.isEmpty) {
      return const Center(
        child: Text('No messages yet. Start the conversation.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: state.messages.length,
      itemBuilder: (context, index) {
        final message = state.messages[index];
        return Align(
          alignment:
              message.isIncoming ? Alignment.centerLeft : Alignment.centerRight,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.content),
                  const SizedBox(height: 6),
                  Text(
                    '${message.senderId} • ${message.status.name}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
