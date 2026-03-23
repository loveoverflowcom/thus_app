import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:thus_auth/thus_auth.dart';

final class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.authenticated:
            context.go('/');
          case AuthStatus.unauthenticated:
            context.go('/login');
          case AuthStatus.initial:
          case AuthStatus.loading:
          case AuthStatus.failure:
            break;
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
