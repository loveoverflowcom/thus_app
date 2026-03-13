import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thus_auth/thus_auth.dart';

import 'chat_list_page.dart';
import 'identity_setup_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, next) => prev.status != next.status,
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.authenticated:
            Navigator.of(context).pushReplacementNamed(ChatListPage.route);
            break;
          case AuthStatus.unauthenticated:
            Navigator.of(context).pushReplacementNamed(IdentitySetupPage.route);
            break;
          default:
            break;
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
