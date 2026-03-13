import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thus_auth/thus_auth.dart';

import 'chat_list_page.dart';

class IdentitySetupPage extends StatefulWidget {
  const IdentitySetupPage({super.key});

  static const route = '/setup';

  @override
  State<IdentitySetupPage> createState() => _IdentitySetupPageState();
}

class _IdentitySetupPageState extends State<IdentitySetupPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set up identity')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            Navigator.of(context).pushReplacementNamed(ChatListPage.route);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter a display name to generate your key pair.'),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(labelText: 'Display name'),
              ),
              const SizedBox(height: 20),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final busy = state.status == AuthStatus.loading;
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: busy || _controller.text.isEmpty
                          ? null
                          : () => context.read<AuthBloc>().add(CreateIdentity(_controller.text)),
                      child: busy ? const CircularProgressIndicator() : const Text('Generate keys'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
