import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_contacts/thus_contacts.dart';

final class ContactsView extends HookWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.read<AuthBloc>().state.session;
    final bloc = useMemoized(
      () => ContactsBloc(context.read<ContactRepository>()),
    );
    useEffect(() {
      if (session != null) {
        bloc.add(ContactsStarted(userId: session.userId));
      }
      return bloc.close;
    }, []);

    return BlocProvider.value(
      value: bloc,
      child: const _ContactsContent(),
    );
  }
}

final class _ContactsContent extends HookWidget {
  const _ContactsContent();

  @override
  Widget build(BuildContext context) {
    final session = context.read<AuthBloc>().state.session;
    final searchController = useTextEditingController();
    final tabController = useTabController(initialLength: 3);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: 'Friends'),
            Tab(text: 'Requests'),
            Tab(text: 'Search'),
          ],
        ),
      ),
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          return TabBarView(
            controller: tabController,
            children: [
              _ContactsList(
                contacts: state.contacts,
                isLoading: state.isLoading,
                userId: session?.userId ?? '',
              ),
              _RequestsList(
                incoming: state.incomingRequests,
                outgoing: state.outgoingRequests,
                userId: session?.userId ?? '',
              ),
              _SearchTab(
                controller: searchController,
                results: state.searchResults,
                myUserId: session?.userId ?? '',
                outgoingRequests: state.outgoingRequests,
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Contacts list tab ──────────────────────────────────────────────────────

final class _ContactsList extends StatelessWidget {
  const _ContactsList({
    required this.contacts,
    required this.isLoading,
    required this.userId,
  });

  final List<Contact> contacts;
  final bool isLoading;
  final String userId;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (contacts.isEmpty) {
      return const Center(child: Text('No contacts yet.'));
    }
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, i) {
        final c = contacts[i];
        final name = c.profile?.displayName ?? c.profile?.username ?? c.contactId;
        return ListTile(
          leading: CircleAvatar(child: Text(name[0].toUpperCase())),
          title: Text(name),
          trailing: IconButton(
            icon: const Icon(Icons.person_remove_outlined),
            tooltip: 'Remove contact',
            onPressed: () => context.read<ContactsBloc>().add(
                  ContactRemoved(userId: userId, otherUserId: c.contactId),
                ),
          ),
        );
      },
    );
  }
}

// ── Requests tab ───────────────────────────────────────────────────────────

final class _RequestsList extends StatelessWidget {
  const _RequestsList({
    required this.incoming,
    required this.outgoing,
    required this.userId,
  });

  final List<ContactRequest> incoming;
  final List<ContactRequest> outgoing;
  final String userId;

  String _formatDate(DateTime dt) {
    final local = dt.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(local.year, local.month, local.day);
    final hh = local.hour.toString().padLeft(2, '0');
    final mm = local.minute.toString().padLeft(2, '0');
    if (date == today) return 'Hôm nay $hh:$mm';
    return '${local.day}/${local.month}/${local.year}';
  }

  @override
  Widget build(BuildContext context) {
    if (incoming.isEmpty && outgoing.isEmpty) {
      return const Center(child: Text('No pending requests.'));
    }
    return ListView(
      children: [
        if (incoming.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              'Incoming',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...incoming.map(
            (r) => ListTile(
              leading: CircleAvatar(
                child: Text(r.fromUser.substring(0, 1).toUpperCase()),
              ),
              title: Text('Người dùng #${r.fromUser.substring(0, 8)}'),
              subtitle: Text(_formatDate(r.createdAt)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    tooltip: 'Accept',
                    onPressed: () =>
                        context.read<ContactsBloc>().add(
                              ContactRequestAccepted(
                                requestId: r.id,
                                userId: userId,
                              ),
                            ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    tooltip: 'Reject',
                    onPressed: () =>
                        context.read<ContactsBloc>().add(
                              ContactRequestRejected(requestId: r.id),
                            ),
                  ),
                ],
              ),
            ),
          ),
        ],
        if (outgoing.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              'Outgoing',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...outgoing.map(
            (r) => ListTile(
              leading: CircleAvatar(
                child: Text(r.toUser.substring(0, 1).toUpperCase()),
              ),
              title: Text('Người dùng #${r.toUser.substring(0, 8)}'),
              subtitle: Text('Đang chờ • ${_formatDate(r.createdAt)}'),
              trailing: IconButton(
                icon: const Icon(Icons.cancel_outlined),
                tooltip: 'Cancel',
                onPressed: () =>
                    context.read<ContactsBloc>().add(
                          ContactRequestCancelled(requestId: r.id),
                        ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ── Search tab ─────────────────────────────────────────────────────────────

final class _SearchTab extends StatelessWidget {
  const _SearchTab({
    required this.controller,
    required this.results,
    required this.myUserId,
    required this.outgoingRequests,
  });

  final TextEditingController controller;
  final List<Profile> results;
  final String myUserId;
  final List<ContactRequest> outgoingRequests;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Search by username',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => context.read<ContactsBloc>().add(
                      ProfileSearched(
                        usernamePrefix: controller.text.trim().isEmpty
                            ? null
                            : controller.text.trim(),
                      ),
                    ),
              ),
            ),
            onSubmitted: (v) => context.read<ContactsBloc>().add(
                  ProfileSearched(
                    usernamePrefix: v.trim().isEmpty ? null : v.trim(),
                  ),
                ),
          ),
        ),
        Expanded(
          child: results.isEmpty
              ? const Center(child: Text('Search for users above.'))
              : ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, i) {
                    final p = results[i];
                    if (p.userId == myUserId) return const SizedBox.shrink();
                    final alreadySent = outgoingRequests
                        .any((r) => r.toUser == p.userId);
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          (p.displayName ?? p.username)[0].toUpperCase(),
                        ),
                      ),
                      title: Text(p.displayName ?? p.username),
                      subtitle: Text('@${p.username}'),
                      trailing: alreadySent
                          ? const Chip(label: Text('Sent'))
                          : IconButton(
                              icon: const Icon(Icons.person_add_outlined),
                              tooltip: 'Add contact',
                              onPressed: () =>
                                  context.read<ContactsBloc>().add(
                                        ContactRequestSent(
                                          fromUser: myUserId,
                                          toUser: p.userId,
                                        ),
                                      ),
                            ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
