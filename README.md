# Thus Chat Monorepo

Monorepo skeleton for a WhatsApp-like, key-based chat platform with shared domain layers, a Flutter mobile app, and a Dart CLI client.

## Structure
- `packages/thus_core` — failures, use cases, logger, DI bootstrap, constants.
- `packages/thus_storage` — Hive CE init, encrypted box helper, generic cache repo.
- `packages/thus_auth` — key-pair identity (generate/load/save), identity bloc.
- `packages/thus_network` — REST (Dio), WebSocket, SSE clients.
- `packages/thus_messaging` — chat/message entities, message status enum, repos, use cases, chat bloc.
- `apps/thus_mobile_app` — Flutter UI (splash → identity setup → chat list → chat view), uses blocs and DI.
- `apps/thus_cli` — terminal client sharing the same domain stack (`/login`, `/chats`, `/send`).

## Platform scaffolds
`apps/thus_mobile_app/android` and `apps/thus_mobile_app/ios` were generated via `flutter create --platforms=ios,android`. They are ready for native builds (update bundle IDs/signing as needed).

## Getting started
1) Fetch deps & generate code (run per package that uses codegen):
```
flutter pub get
dart pub get --directory packages/thus_core
flutter pub get --directory packages/thus_storage
flutter pub get --directory packages/thus_auth
flutter pub get --directory packages/thus_network
flutter pub get --directory packages/thus_messaging
flutter pub get --directory apps/thus_mobile_app
flutter pub get --directory apps/thus_cli
flutter pub run build_runner build --delete-conflicting-outputs --directory packages/thus_auth
flutter pub run build_runner build --delete-conflicting-outputs --directory packages/thus_messaging
```

2) Run mobile app (iOS/Android):
```
cd apps/thus_mobile_app
flutter run
```

3) Run CLI client:
```
cd apps/thus_cli
flutter pub get
dart run bin/thus_cli.dart /login "Your Name"
dart run bin/thus_cli.dart /send user123 "Hello"
```

## Linting (very_good_analysis)
- All packages/apps include `very_good_analysis`. The root `analysis_options.yaml` includes it as well.
- Add/keep `dev_dependencies: very_good_analysis` in each pubspec (already added).
- Suppress rules only when justified (line/file/project level via `// ignore:`).

## Architectural notes
- DI: `get_it` + module functions per package (`register*Module`).
- State: `flutter_bloc` for auth/chat flows.
- Storage: Hive CE with encrypted box via `HiveInitializer`; cache via `CacheRepository` factory.
- Auth: key-pair (Ed25519) identities persisted locally.
- Messaging: REST send + WebSocket subscribe; local cache for history; `MessageStatus` covers sending→read.

## Next steps
- Wire real backend endpoints & WebSocket URLs.
- Add e2e tests for auth and messaging flows.
- Configure CI to run `flutter analyze` and `flutter test` across all packages.
