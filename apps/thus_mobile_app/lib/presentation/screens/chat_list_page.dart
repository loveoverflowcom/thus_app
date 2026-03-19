import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';

import '../../di/di.dart';
import 'chat_page.dart';
import 'identity_setup_page.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  static const String route = '/chats';

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final TextEditingController _targetUserController = TextEditingController();

  @override
  void dispose() {
    _targetUserController.dispose();
    super.dispose();
  }

  Future<List<Chat>> _loadChats() {
    return sl<LoadChats>()(const NoParams());
  }

  @override
  Widget build(BuildContext context) {
    final AuthState authState = context.watch<AuthBloc>().state;
    final AuthSession? session = authState.session;

    return Scaffold(
      appBar: AppBar(
        title: Text(session?.username ?? 'Thus Chats'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(const LogoutRequested());
              Navigator.of(
                context,
              ).pushReplacementNamed(IdentitySetupPage.route);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: FutureBuilder<List<Chat>>(
          future: _loadChats(),
          builder: (BuildContext context, AsyncSnapshot<List<Chat>> snapshot) {
            final List<Chat> chats = snapshot.data ?? const <Chat>[];

            return ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                  controller: _targetUserController,
                  decoration: const InputDecoration(
                    labelText: 'Open chat by target user id',
                    hintText: 'e.g. 8df1f8a9...',
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () {
                    final String peerUserId = _targetUserController.text.trim();
                    if (peerUserId.isEmpty) {
                      return;
                    }
                    Navigator.of(context)
                        .pushNamed(ChatPage.route, arguments: peerUserId)
                        .then((_) => setState(() {}));
                  },
                  child: const Text('Open chat'),
                ),
                const SizedBox(height: 24),
                Text(
                  'Cached conversations',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const Center(child: CircularProgressIndicator())
                else if (chats.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      'No cached chats yet. Send a message or receive one over SSE to populate this list.',
                    ),
                  )
                else
                  ...chats.map(
                    (Chat chat) => Card(
                      child: ListTile(
                        title: Text(chat.title),
                        subtitle: Text(
                          chat.lastMessage?.content ?? 'No message',
                        ),
                        trailing: Text(
                          chat.updatedAt?.toLocal().toIso8601String() ?? '-',
                          textAlign: TextAlign.end,
                        ),
                        onTap: () => Navigator.of(context)
                            .pushNamed(ChatPage.route, arguments: chat.id)
                            .then((_) => setState(() {})),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
