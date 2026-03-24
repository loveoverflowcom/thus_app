import 'dart:io';

import 'package:thus_auth/thus_auth.dart';
import 'package:thus_contacts/thus_contacts.dart';

import 'package:thus_cli/src/commands/command_handler.dart';
import 'package:thus_cli/src/commands/command_help.dart';

/// /contacts                  — list my contacts
/// /contacts search <prefix>  — search profiles by username prefix
/// /contacts add <user_id>    — send contact request
/// /contacts accept <req_id>  — accept incoming request
/// /contacts reject <req_id>  — reject incoming request
/// /contacts cancel <req_id>  — cancel outgoing request
/// /contacts remove <user_id> — remove a contact
/// /contacts requests         — list all pending requests
class ContactsCommand extends CommandHandler {
  ContactsCommand(this._authRepository, this._contactRepository);

  static const CommandHelp helpInfo = CommandHelp(
    command: '/contacts',
    usage: '/contacts [search|add|accept|reject|cancel|remove|requests] [args]',
    summary: 'Manage contacts and contact requests.',
    examples: <String>[
      '/contacts',
      '/contacts search alice',
      '/contacts add <user_id>',
      '/contacts accept <request_id>',
      '/contacts reject <request_id>',
      '/contacts cancel <request_id>',
      '/contacts remove <user_id>',
      '/contacts requests',
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
      await _listContacts(session.userId);
      return;
    }

    final sub = args.first;
    final rest = args.skip(1).toList();

    switch (sub) {
      case 'search':
        await _search(rest.isEmpty ? null : rest.join(' '));
      case 'add':
        if (rest.isEmpty) {
          stdout.writeln('Usage: /contacts add <user_id>');
          return;
        }
        await _sendRequest(session.userId, rest.first);
      case 'accept':
        if (rest.isEmpty) {
          stdout.writeln('Usage: /contacts accept <request_id>');
          return;
        }
        await _acceptRequest(rest.first);
      case 'reject':
        if (rest.isEmpty) {
          stdout.writeln('Usage: /contacts reject <request_id>');
          return;
        }
        await _rejectRequest(rest.first);
      case 'cancel':
        if (rest.isEmpty) {
          stdout.writeln('Usage: /contacts cancel <request_id>');
          return;
        }
        await _cancelRequest(rest.first);
      case 'remove':
        if (rest.isEmpty) {
          stdout.writeln('Usage: /contacts remove <user_id>');
          return;
        }
        await _removeContact(rest.first);
      case 'requests':
        await _listRequests(session.userId);
      default:
        stdout.writeln('Unknown subcommand: $sub');
        stdout.writeln(formatHelp());
    }
  }

  Future<void> _listContacts(String userId) async {
    final result = await _contactRepository.listMyContacts(userId).run();
    result.match(
      (f) => stdout.writeln('Failed: ${f.message}'),
      (contacts) {
        if (contacts.isEmpty) {
          stdout.writeln('No contacts yet.');
          return;
        }
        for (final c in contacts) {
          final name = c.profile?.displayName ??
              c.profile?.username ??
              c.contactId;
          stdout.writeln('${c.contactId} | $name');
        }
      },
    );
  }

  Future<void> _search(String? prefix) async {
    final result = await _contactRepository
        .searchProfiles(usernamePrefix: prefix)
        .run();
    result.match(
      (f) => stdout.writeln('Failed: ${f.message}'),
      (profiles) {
        if (profiles.isEmpty) {
          stdout.writeln('No profiles found.');
          return;
        }
        for (final p in profiles) {
          stdout.writeln(
            '${p.userId} | @${p.username} | ${p.displayName ?? '-'}',
          );
        }
      },
    );
  }

  Future<void> _sendRequest(String fromUser, String toUser) async {
    final result = await _contactRepository
        .sendContactRequest(fromUser: fromUser, toUser: toUser)
        .run();
    result.match(
      (f) => stdout.writeln('Failed: ${f.message}'),
      (req) => stdout.writeln('Request sent (id: ${req.id})'),
    );
  }

  Future<void> _acceptRequest(String requestId) async {
    final result =
        await _contactRepository.acceptContactRequest(requestId).run();
    result.match(
      (f) => stdout.writeln('Failed: ${f.message}'),
      (_) => stdout.writeln('Request accepted.'),
    );
  }

  Future<void> _rejectRequest(String requestId) async {
    final result =
        await _contactRepository.rejectContactRequest(requestId).run();
    result.match(
      (f) => stdout.writeln('Failed: ${f.message}'),
      (_) => stdout.writeln('Request rejected.'),
    );
  }

  Future<void> _cancelRequest(String requestId) async {
    final result =
        await _contactRepository.cancelContactRequest(requestId).run();
    result.match(
      (f) => stdout.writeln('Failed: ${f.message}'),
      (_) => stdout.writeln('Request cancelled.'),
    );
  }

  Future<void> _removeContact(String otherUserId) async {
    final result =
        await _contactRepository.removeContact(otherUserId).run();
    result.match(
      (f) => stdout.writeln('Failed: ${f.message}'),
      (_) => stdout.writeln('Contact removed.'),
    );
  }

  Future<void> _listRequests(String userId) async {
    final incoming =
        (await _contactRepository.listIncomingRequests(userId).run())
            .getOrElse((_) => []);
    final outgoing =
        (await _contactRepository.listOutgoingRequests(userId).run())
            .getOrElse((_) => []);

    if (incoming.isEmpty && outgoing.isEmpty) {
      stdout.writeln('No pending requests.');
      return;
    }

    if (incoming.isNotEmpty) {
      stdout.writeln('--- Incoming ---');
      for (final r in incoming) {
        stdout.writeln('${r.id} | from: ${r.fromUser}');
      }
    }
    if (outgoing.isNotEmpty) {
      stdout.writeln('--- Outgoing ---');
      for (final r in outgoing) {
        stdout.writeln('${r.id} | to: ${r.toUser}');
      }
    }
  }
}
