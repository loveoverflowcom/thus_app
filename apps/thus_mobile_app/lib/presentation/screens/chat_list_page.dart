import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thus_auth/thus_auth.dart';

import 'chat_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  static const route = '/chats';

  @override
  Widget build(BuildContext context) {
    final conversations = const ['general', 'team', 'support'];
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => Text('Chats — ${state.identity?.displayName ?? 'guest'}'),
        ),
      ),
      body: ListView.separated(
        itemCount: conversations.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final id = conversations[index];
          return ListTile(
            title: Text('#$id'),
            subtitle: const Text('Tap to open'),
            onTap: () => Navigator.of(context).pushNamed(ChatPage.route, arguments: id),
          );
        },
      ),
    );
  }
}
