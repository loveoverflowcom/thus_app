import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:thus_auth/thus_auth.dart';

import 'package:thus_mobile_app/theme/theme_cubit.dart';

final class PersonalView extends StatelessWidget {
  const PersonalView({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<AuthBloc>().state.session;
    final themeMode = context.watch<ThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('Personal')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('Username: ${session?.username ?? '-'}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.badge_outlined),
                  title: const Text('Edit profile'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push('/profile'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(_themeModeIcon(themeMode)),
                  title: const Text('Giao diện'),
                  trailing: DropdownButton<ThemeMode>(
                    value: themeMode,
                    underline: const SizedBox.shrink(),
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('Hệ thống'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Sáng'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Tối'),
                      ),
                    ],
                    onChanged: (mode) {
                      if (mode != null) context.read<ThemeCubit>().setTheme(mode);
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Sign out'),
                  onTap: () {
                    context
                        .read<AuthBloc>()
                        .add(const AuthEvent.logoutRequested());
                    context.go('/login');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _themeModeIcon(ThemeMode mode) => switch (mode) {
        ThemeMode.system => Icons.brightness_auto,
        ThemeMode.light => Icons.light_mode,
        ThemeMode.dark => Icons.dark_mode,
      };
}
