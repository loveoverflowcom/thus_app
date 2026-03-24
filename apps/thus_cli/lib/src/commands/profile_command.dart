import 'dart:io';

import 'package:thus_auth/thus_auth.dart';
import 'package:thus_contacts/thus_contacts.dart';

import 'package:thus_cli/src/commands/command_handler.dart';
import 'package:thus_cli/src/commands/command_help.dart';

class ProfileCommand extends CommandHandler {
  ProfileCommand(this._authRepository, this._contactRepository);

  static const CommandHelp helpInfo = CommandHelp(
    command: '/profile',
    usage: '/profile [display_name] [bio]',
    summary: 'Show or update your profile. No args = show, 2 args = update.',
    examples: <String>[
      '/profile',
      '/profile "Alice Nguyen" "Flutter dev"',
    ],
  );

  final AuthRepository _authRepository;
  final ContactRepository _contactRepository;

  @override
  CommandHelp get help => helpInfo;

  @override
  Future<void> handle(List<String> args) async {
    final sessionResult = await _authRepository.loadSession().run();
    final session = sessionResult.getOrElse((_) => null);
    if (session == null) {
      stdout.writeln('Login first with /login <username> <password>');
      return;
    }

    if (args.isEmpty) {
      final result =
          await _contactRepository.getMyProfile(session.userId).run();
      result.match(
        (f) => stdout.writeln('Failed: ${f.message}'),
        (p) {
          stdout.writeln('username:     ${p.username}');
          stdout.writeln('display_name: ${p.displayName ?? '-'}');
          stdout.writeln('bio:          ${p.bio ?? '-'}');
          stdout.writeln('avatar_url:   ${p.avatarUrl ?? '-'}');
        },
      );
      return;
    }

    final result = await _contactRepository
        .updateMyProfile(
          userId: session.userId,
          displayName: args.isNotEmpty ? args[0] : null,
          bio: args.length > 1 ? args.sublist(1).join(' ') : null,
        )
        .run();
    result.match(
      (f) => stdout.writeln('Update failed: ${f.message}'),
      (p) => stdout.writeln('Profile updated: ${p.displayName}'),
    );
  }
}
