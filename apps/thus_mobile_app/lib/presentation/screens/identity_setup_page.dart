import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thus_auth/thus_auth.dart';

import 'chat_list_page.dart';

class IdentitySetupPage extends StatefulWidget {
  const IdentitySetupPage({super.key});

  static const String route = '/setup';

  @override
  State<IdentitySetupPage> createState() => _IdentitySetupPageState();
}

class _IdentitySetupPageState extends State<IdentitySetupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in to Thus')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state.status == AuthStatus.authenticated) {
            Navigator.of(context).pushReplacementNamed(ChatListPage.route);
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            final bool busy = state.status == AuthStatus.loading;
            final bool canSubmit =
                _usernameController.text.trim().isNotEmpty &&
                _passwordController.text.trim().isNotEmpty &&
                !busy;

            return ListView(
              padding: const EdgeInsets.all(24),
              children: <Widget>[
                Text(
                  'Connect to EvoBase using username/password and store the token session locally.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _usernameController,
                  onChanged: (_) => setState(() {}),
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  onChanged: (_) => setState(() {}),
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 20),
                if (state.status == AuthStatus.failure &&
                    state.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      state.errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                FilledButton(
                  onPressed: canSubmit
                      ? () => context.read<AuthBloc>().add(
                          LoginSubmitted(
                            username: _usernameController.text.trim(),
                            password: _passwordController.text,
                          ),
                        )
                      : null,
                  child: busy
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Login'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: canSubmit
                      ? () => context.read<AuthBloc>().add(
                          RegisterSubmitted(
                            username: _usernameController.text.trim(),
                            password: _passwordController.text,
                          ),
                        )
                      : null,
                  child: const Text('Register'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
