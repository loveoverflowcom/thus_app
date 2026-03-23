import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:thus_auth/thus_auth.dart';

final class IdentitySetupView extends HookWidget {
  const IdentitySetupView({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();

    // Rebuild when controllers change so canSubmit updates
    useListenable(usernameController);
    useListenable(passwordController);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign in to Thus')),
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status.isAuthenticated) {
            context.go('/');
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final busy = state.status.isLoading;
            final canSubmit = usernameController.text.trim().isNotEmpty &&
                passwordController.text.trim().isNotEmpty &&
                !busy;

            return ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  'Connect to EvoBase using username/password and store the token session locally.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: usernameController,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 20),
                if (state.status.isFailure && state.message != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      state.message!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                FilledButton(
                  onPressed: canSubmit
                      ? () => context.read<AuthBloc>().add(
                            AuthEvent.loginSubmitted(
                              username: usernameController.text.trim(),
                              password: passwordController.text,
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
                            AuthEvent.registerSubmitted(
                              username: usernameController.text.trim(),
                              password: passwordController.text,
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
