import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_messaging/thus_messaging.dart';

import '../../di/di.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.conversationId});

  static const route = '/chat';
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
      appBar: AppBar(title: Text('#${widget.conversationId}')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state.status == ChatStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final messages = state.messages;
                if (messages.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (_, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Text(message.content),
                      subtitle: Text('${message.senderId} • ${message.status.name}'),
                      trailing: Text(message.timestamp.toLocal().toIso8601String()),
                    );
                  },
                );
              },
            ),
          ),
          _MessageInput(conversationId: widget.conversationId, controller: _controller),
        ],
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({required this.conversationId, required this.controller});

  final String conversationId;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final senderId = authState.identity?.id ?? 'unknown';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(hintText: 'Message'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                final text = controller.text.trim();
                if (text.isEmpty) return;
                controller.clear();
                context.read<ChatBloc>().add(
                      SendChatMessage(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        senderId: senderId,
                        receiverId: conversationId,
                        content: text,
                        status: MessageStatus.sending,
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
