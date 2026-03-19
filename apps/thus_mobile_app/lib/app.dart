import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thus_auth/thus_auth.dart';

import 'di/di.dart';
import 'presentation/screens/chat_list_page.dart';
import 'presentation/screens/chat_page.dart';
import 'presentation/screens/identity_setup_page.dart';
import 'presentation/screens/splash_page.dart';

class ThusApp extends StatelessWidget {
  const ThusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()..add(const AppStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'Thus Chat',
        theme: ThemeData.dark(useMaterial3: true),
        routes: {
          SplashPage.route: (_) => const SplashPage(),
          IdentitySetupPage.route: (_) => const IdentitySetupPage(),
          ChatListPage.route: (_) => const ChatListPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == ChatPage.route) {
            final conversationId = settings.arguments as String? ?? 'general';
            return MaterialPageRoute<void>(
              builder: (_) => ChatPage(conversationId: conversationId),
            );
          }
          return null;
        },
        initialRoute: SplashPage.route,
      ),
    );
  }
}
