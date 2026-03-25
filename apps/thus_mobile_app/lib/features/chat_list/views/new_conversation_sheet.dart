import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:thus_contacts/thus_contacts.dart';

import 'package:thus_mobile_app/features/chat_list/blocs/user_search_bloc.dart';

class NewConversationSheet extends HookWidget {
  const NewConversationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSearchBloc(context.read<ContactRepository>()),
      child: const _SheetContent(),
    );
  }
}

class _SheetContent extends HookWidget {
  const _SheetContent();

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Cuộc trò chuyện mới',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Tìm kiếm theo username...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => context
                      .read<UserSearchBloc>()
                      .add(UserSearchEvent.queryChanged(value)),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<UserSearchBloc, UserSearchState>(
                  builder: (context, state) {
                    return switch (state.status) {
                      UserSearchStatus.idle => const _IdleHint(),
                      UserSearchStatus.loading =>
                        const Center(child: CircularProgressIndicator()),
                      UserSearchStatus.success => state.results.isEmpty
                          ? const _EmptyResults()
                          : _ResultList(
                              results: state.results,
                              scrollController: scrollController,
                            ),
                      UserSearchStatus.failure => _ErrorView(
                          message: state.errorMessage,
                          onRetry: () => context
                              .read<UserSearchBloc>()
                              .add(const UserSearchEvent.retried()),
                        ),
                    };
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _IdleHint extends StatelessWidget {
  const _IdleHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Nhập username để tìm kiếm',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.outline),
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Không tìm thấy người dùng'));
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry, this.message});

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message ?? 'Đã xảy ra lỗi',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}

class _ResultList extends StatelessWidget {
  const _ResultList({
    required this.results,
    required this.scrollController,
  });

  final List<Profile> results;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: results.length,
      itemBuilder: (context, index) {
        final profile = results[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              (profile.displayName ?? profile.username)
                  .substring(0, 1)
                  .toUpperCase(),
            ),
          ),
          title: Text(profile.username),
          subtitle: profile.displayName != null
              ? Text(profile.displayName!)
              : null,
          onTap: () {
            Navigator.of(context).pop();
            context.push('/chat/${profile.userId}');
          },
        );
      },
    );
  }
}
