import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thus_messaging/thus_messaging.dart';

import '../../di/di.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({required this.conversationId, super.key});

  static const String route = '/chat';

  final String conversationId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      create: (_) => sl<ChatBloc>()..add(LoadConversation(conversationId)),
      child: _ChatView(conversationId: conversationId),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView({required this.conversationId});

  final String conversationId;

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.conversationId)),
      body: Column(
        children: <Widget>[
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (BuildContext context, ChatState state) {
                if (state.status == ChatStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.status == ChatStatus.failure) {
                  return Center(
                    child: Text(state.errorMessage ?? 'Unable to load chat.'),
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
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = state.messages[index];
                    return Align(
                      alignment: message.isIncoming
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
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
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final String content = _controller.text.trim();
                      if (content.isEmpty) {
                        return;
                      }

                      _controller.clear();
                      context.read<ChatBloc>().add(
                        SendChatMessage(
                          receiverId: widget.conversationId,
                          content: content,
                        ),
                      );
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
