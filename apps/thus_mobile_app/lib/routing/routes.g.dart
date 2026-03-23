// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $loginRoute,
      $chatRoute,
      $mainShellRoute,
    ];

RouteBase get $splashRoute => GoRoute(
      path: '/splash',
      name: _$SplashRouteExtension._name,
      builder: (context, state) => const SplashRoute().build(context, state),
    );

extension _$SplashRouteExtension on SplashRoute {
  static const String _name = 'SplashRoute';

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);

  String get location => GoRouteData.$location('/splash');
}

RouteBase get $loginRoute => GoRoute(
      path: '/login',
      name: _$LoginRouteExtension._name,
      builder: (context, state) => const LoginRoute().build(context, state),
    );

extension _$LoginRouteExtension on LoginRoute {
  static const String _name = 'LoginRoute';

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);

  String get location => GoRouteData.$location('/login');
}

RouteBase get $chatRoute => GoRoute(
      path: '/chat/:conversationId',
      name: _$ChatRouteExtension._name,
      builder: (context, state) => ChatRoute(
        conversationId: state.pathParameters['conversationId']!,
      ).build(context, state),
    );

extension _$ChatRouteExtension on ChatRoute {
  static const String _name = 'ChatRoute';

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);

  String get location =>
      GoRouteData.$location('/chat/${Uri.encodeComponent(conversationId)}');
}

RouteBase get $mainShellRoute => ShellRoute(
      builder: (context, state, child) =>
          const MainShellRoute().builder(context, state, child),
      routes: [
        GoRoute(
          path: '/',
          name: _$HomeTabRouteExtension._name,
          builder: (context, state) =>
              const HomeTabRoute().build(context, state),
        ),
        GoRoute(
          path: '/personal',
          name: _$PersonalTabRouteExtension._name,
          builder: (context, state) =>
              const PersonalTabRoute().build(context, state),
        ),
      ],
    );

extension _$HomeTabRouteExtension on HomeTabRoute {
  static const String _name = 'HomeTabRoute';

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);

  String get location => GoRouteData.$location('/');
}

extension _$PersonalTabRouteExtension on PersonalTabRoute {
  static const String _name = 'PersonalTabRoute';

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);

  String get location => GoRouteData.$location('/personal');
}
