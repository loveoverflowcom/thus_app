import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:thus_messaging/thus_messaging.dart';

import 'package:thus_mobile_app/features/chat_list/views/new_conversation_sheet.dart';

final class ChatListView extends HookWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<ChatListBloc>().add(const ChatListEvent.started());
      return null;
    }, const []);

    return BlocConsumer<ChatListBloc, ChatListState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status && curr.status.isFailure,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message ?? 'Đã xảy ra lỗi.')),
        );
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'launch_assets/thus_logo.png',
                height: 28,
                width: 28,
              ),
              const SizedBox(width: 8),
              const Text('Thus Chat'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Cuộc trò chuyện mới',
              onPressed: () => _openNewConversation(context),
            ),
          ],
        ),
        body: _ChatListBody(state: state),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openNewConversation(context),
          tooltip: 'Cuộc trò chuyện mới',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _openNewConversation(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const NewConversationSheet(),
    );
  }
}

// ─────────────────────────────
// Body
// ─────────────────────────────

class _ChatListBody extends StatelessWidget {
  const _ChatListBody({required this.state});

  final ChatListState state;

  @override
  Widget build(BuildContext context) {
    if (state.status.isLoading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status.isSuccess && state.items.isEmpty) {
      return const _EmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ChatListBloc>().add(const ChatListEvent.refreshed());
        await context.read<ChatListBloc>().stream.firstWhere(
              (s) => !s.status.isLoading,
            );
      },
      child: ListView.separated(
        itemCount: state.items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) =>
            _ChatItem(item: state.items[index]),
      ),
    );
  }
}

// ─────────────────────────────
// Chat Item
// ─────────────────────────────

class _ChatItem extends StatelessWidget {
  const _ChatItem({required this.item});

  final ChatListItem item;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatListBloc>();
    final avatarUrl = item.avatarUrl;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
            avatarUrl != null && avatarUrl.isNotEmpty
                ? NetworkImage(avatarUrl)
                : null,
        child: avatarUrl == null || avatarUrl.isEmpty
            ? Text(item.avatarInitial)
            : null,
      ),
      title: Text(
        item.displayName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        item.chat.lastMessage?.content ?? 'Chưa có tin nhắn',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: item.chat.updatedAt != null
          ? Text(
              _formatTime(item.chat.updatedAt!),
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,
      onTap: () => context
          .push('/chat/${item.chat.id}')
          .then((_) => bloc.add(const ChatListEvent.refreshed())),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final local = dt.toLocal();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final date = DateTime(local.year, local.month, local.day);
    final hh = local.hour.toString().padLeft(2, '0');
    final mm = local.minute.toString().padLeft(2, '0');
    if (date == today) return '$hh:$mm';
    if (date == yesterday) return 'Hôm qua';
    return '${local.day}/${local.month}';
  }
}

// ─────────────────────────────
// Empty State
// ─────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'Chưa có cuộc trò chuyện nào',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Nhấn nút + để bắt đầu trò chuyện mới',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}
