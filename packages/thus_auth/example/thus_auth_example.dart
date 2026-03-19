import 'dart:io';

import 'package:thus_auth/thus_auth.dart';

void main() {
  const AuthCredentials credentials = AuthCredentials(
    username: 'alice',
    password: 'secret',
  );

  stdout.writeln(
    'Auth example credentials prepared for ${credentials.username}.',
  );
}
