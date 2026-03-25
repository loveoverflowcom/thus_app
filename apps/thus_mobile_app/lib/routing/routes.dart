import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_contacts/thus_contacts.dart';
import 'package:thus_messaging/thus_messaging.dart';

import 'package:thus_mobile_app/features/auth/views.dart';
import 'package:thus_mobile_app/features/chat/views.dart';
import 'package:thus_mobile_app/features/chat_list/views.dart';
import 'package:thus_mobile_app/features/contacts/views.dart';
import 'package:thus_mobile_app/features/personal/views.dart';
import 'package:thus_mobile_app/features/profile/views.dart';
import 'package:thus_mobile_app/features/splash/views.dart';
import 'package:thus_mobile_app/widgets/main_shell.dart';

part 'routes.g.dart';

GoRouter buildAppRouter() => GoRouter(
      routes: $appRoutes,
      initialLocation: '/splash',
      redirect: (context, state) {
        final authStatus = context.read<AuthBloc>().state.status;
        final isOnSplash = state.matchedLocation == '/splash';
        if (isOnSplash) return null;
        if (authStatus == AuthStatus.unauthenticated &&
            state.matchedLocation != '/login') {
          return '/login';
        }
        return null;
      },
    );

@TypedGoRoute<SplashRoute>(path: '/splash')
final class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashView();
}

@TypedGoRoute<LoginRoute>(path: '/login')
final class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const IdentitySetupView();
}

@TypedGoRoute<ChatRoute>(path: '/chat/:conversationId')
final class ChatRoute extends GoRouteData with $ChatRoute {
  const ChatRoute({required this.conversationId});

  final String conversationId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ChatView(conversationId: conversationId);
}

@TypedShellRoute<MainShellRoute>(
  routes: [
    TypedGoRoute<HomeTabRoute>(path: '/'),
    TypedGoRoute<ContactsTabRoute>(path: '/contacts'),
    TypedGoRoute<PersonalTabRoute>(path: '/personal'),
  ],
)
final class MainShellRoute extends ShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MainShell(child: navigator);
  }
}

final class HomeTabRoute extends GoRouteData with $HomeTabRoute {
  const HomeTabRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      BlocProvider(
        create: (context) => ChatListBloc(
          context.read<MessageRepository>(),
          context.read<ContactRepository>(),
          ProfileCache(),
        ),
        child: const ChatListView(),
      );
}

final class ContactsTabRoute extends GoRouteData with $ContactsTabRoute {
  const ContactsTabRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ContactsView();
}

final class PersonalTabRoute extends GoRouteData with $PersonalTabRoute {
  const PersonalTabRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PersonalView();
}

@TypedGoRoute<ProfileRoute>(path: '/profile')
final class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileView();
}
