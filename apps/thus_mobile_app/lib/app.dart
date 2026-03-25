import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_contacts/thus_contacts.dart';
import 'package:thus_messaging/thus_messaging.dart';

import 'package:thus_mobile_app/di/di.dart';
import 'package:thus_mobile_app/routing/routes.dart';
import 'package:thus_mobile_app/theme/app_theme.dart';
import 'package:thus_mobile_app/theme/theme_cubit.dart';

final class ThusApp extends StatelessWidget {
  const ThusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const RepositoriesInjector(child: _AppRouter()),
    );
  }
}

final class _AppRouter extends HookWidget {
  const _AppRouter();

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    final authBloc = useMemoized(() => AuthBloc(authRepository));
    useEffect(() {
      authBloc.add(const AuthEvent.started());
      context.read<MessageRepository>().startListening().run();
      FlutterNativeSplash.remove();
      return authBloc.close;
    }, []);

    final router = useMemoized(buildAppRouter);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: authRepository),
        RepositoryProvider<MessageRepository>.value(
          value: context.read<MessageRepository>(),
        ),
        RepositoryProvider<ContactRepository>.value(
          value: context.read<ContactRepository>(),
        ),
      ],
      child: BlocProvider.value(
        value: authBloc,
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) => MaterialApp.router(
            title: 'Thus',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
            routerConfig: router,
          ),
        ),
      ),
    );
  }
}
