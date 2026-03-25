import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thus_contacts/thus_contacts.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';

final class ChatView extends HookWidget {
  const ChatView({required this.conversationId, super.key});

  final String conversationId;

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized(
      () => ChatBloc(
        context.read<MessageRepository>(),
        context.read<ContactRepository>(),
        ProfileCache(),
      ),
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
    final scrollController = useScrollController();

    void sendMessage() {
      final content = messageController.text.trim();
      if (content.isEmpty) return;

      final receiverId = conversationId.trim();
      if (!isUuid(receiverId)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ID cuộc trò chuyện không hợp lệ.')),
        );
        return;
      }

      messageController.clear();
      context.read<ChatBloc>().add(
            ChatEvent.messageSent(receiverId: receiverId, content: content),
          );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
    }

    return BlocConsumer<ChatBloc, ChatState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status && curr.status.isFailure,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message ?? 'Không thể gửi tin nhắn.')),
        );
      },
      builder: (context, state) {
        final peer = state.peerProfile;
        final peerName = peer != null
            ? (peer.displayName ?? peer.username)
            : (isUuid(conversationId)
                ? '#${conversationId.substring(0, 8)}'
                : conversationId);
        final avatarUrl = peer?.avatarUrl;
        final avatarInitial = peerName.isNotEmpty
            ? peerName[0].toUpperCase()
            : '?';

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                      ? NetworkImage(avatarUrl)
                      : null,
                  child: avatarUrl == null || avatarUrl.isEmpty
                      ? Text(avatarInitial,
                          style: const TextStyle(fontSize: 14))
                      : null,
                ),
                const SizedBox(width: 10),
                Text(peerName),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(child: _buildBody(context, state, scrollController)),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => sendMessage(),
                          decoration: const InputDecoration(
                            hintText: 'Nhập tin nhắn...',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
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

  Widget _buildBody(
    BuildContext context,
    ChatState state,
    ScrollController scrollController,
  ) {
    if (state.status.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.status.isFailure) {
      return Center(child: Text(state.message ?? 'Không thể tải chat.'));
    }
    if (state.items.isEmpty) {
      return const Center(
        child: Text('Chưa có tin nhắn. Hãy bắt đầu cuộc trò chuyện.'),
      );
    }
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: state.items.length,
      itemBuilder: (_, index) => _MessageBubble(item: state.items[index]),
    );
  }
}

// ─────────────────────────────
// Message Bubble
// ─────────────────────────────

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.item});

  final ConversationItem item;

  @override
  Widget build(BuildContext context) {
    final msg = item.message;
    final isOutgoing = !msg.isIncoming;
    final colorScheme = Theme.of(context).colorScheme;

    final bubbleColor = isOutgoing
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerHighest;
    final textColor =
        isOutgoing ? colorScheme.onPrimaryContainer : colorScheme.onSurface;

    return Align(
      alignment: isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isOutgoing ? 16 : 4),
            bottomRight: Radius.circular(isOutgoing ? 4 : 16),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment:
              isOutgoing ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isOutgoing)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  item.senderDisplayName,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            Text(msg.content, style: TextStyle(color: textColor)),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(msg.timestamp),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: textColor.withValues(alpha: 0.6),
                      ),
                ),
                if (isOutgoing) ...[
                  const SizedBox(width: 4),
                  Icon(
                    _statusIcon(msg.status),
                    size: 12,
                    color: textColor.withValues(alpha: 0.6),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final local = dt.toLocal();
    return '${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}';
  }

  IconData _statusIcon(MessageStatus status) => switch (status) {
        MessageStatus.sending => Icons.access_time,
        MessageStatus.sent => Icons.done,
        MessageStatus.delivered => Icons.done_all,
        MessageStatus.read => Icons.done_all,
      };
}
