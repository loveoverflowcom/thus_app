import 'dart:async';

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
  StreamSubscription<Message>? _incomingSubscription;
  Timer? _incomingReconnectTimer;
  bool _isConnectingIncomingStream = false;
  String? _targetUserErrorText;

  @override
  void initState() {
    super.initState();
    _listenForIncomingMessages();
  }

  @override
  void dispose() {
    _incomingSubscription?.cancel();
    _incomingReconnectTimer?.cancel();
    _targetUserController.dispose();
    super.dispose();
  }

  Future<List<Chat>> _loadChats() {
    return sl<MessageRepository>().loadChats();
  }

  Future<void> _listenForIncomingMessages({bool showError = true}) async {
    if (_isConnectingIncomingStream) {
      return;
    }

    _isConnectingIncomingStream = true;
    try {
      final Stream<Message> stream = sl<MessageRepository>().incoming();
      if (!mounted) {
        return;
      }

      _incomingSubscription = stream.listen(
        (_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        },
        onError: (Object error, StackTrace stackTrace) {
          _handleIncomingStreamInterrupted(
            message: 'Live updates disconnected: $error',
          );
        },
        onDone: _handleIncomingStreamInterrupted,
        cancelOnError: true,
      );
    } on Object catch (error) {
      if (!mounted) {
        return;
      }

      if (showError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unable to start live updates: $error')),
          );
        });
      }
      _scheduleIncomingReconnect();
    } finally {
      _isConnectingIncomingStream = false;
    }
  }

  void _handleIncomingStreamInterrupted({String? message}) {
    if (!mounted) {
      return;
    }

    _incomingSubscription = null;
    if (message != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
    _scheduleIncomingReconnect();
  }

  void _scheduleIncomingReconnect() {
    _incomingReconnectTimer?.cancel();
    _incomingReconnectTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) {
        return;
      }
      _listenForIncomingMessages(showError: false);
    });
  }

  static const String _targetUserIdErrorMessage =
      'Target user id must be a UUID, not a username.';

  void _openChat() {
    final String peerUserId = _targetUserController.text.trim();
    if (peerUserId.isEmpty) {
      setState(() {
        _targetUserErrorText = 'Please enter a target user UUID.';
      });
      return;
    }

    if (!isUuid(peerUserId)) {
      setState(() {
        _targetUserErrorText = _targetUserIdErrorMessage;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(_targetUserIdErrorMessage)));
      return;
    }

    setState(() {
      _targetUserErrorText = null;
    });
    Navigator.of(context)
        .pushNamed(ChatPage.route, arguments: peerUserId)
        .then((_) => setState(() {}));
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
                  onChanged: (_) {
                    if (_targetUserErrorText == null) {
                      return;
                    }

                    setState(() {
                      _targetUserErrorText = null;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Open chat by target user UUID',
                    hintText: 'e.g. 115cd206-5696-4eb0-92c0-00f6d9a99408',
                    helperText: 'The API expects user_id UUID, not username.',
                    errorText: _targetUserErrorText,
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: _openChat,
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
