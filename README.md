# Thus Chat Monorepo

Monorepo cho client chat kiểu WhatsApp chạy trên EvoBase API, gồm Flutter mobile app, Dart CLI, và các package domain dùng chung.

## Structure
- `packages/thus_core`: constants, logger, failure, use case primitives.
- `packages/thus_storage`: Hive CE bootstrap, persisted encryption key, generic JSON cache repository.
- `packages/thus_auth`: EvoBase auth session (`/auth/register`, `/auth/login`, `/auth/refresh`), local session store, `AuthBloc`.
- `packages/thus_network`: Dio REST client, SSE parser/client, optional WebSocket client.
- `packages/thus_messaging`: message/chat entities, local history cache, `/messages/send`, `/events` SSE subscription, `ChatBloc`.
- `apps/thus_mobile_app`: Flutter UI (`Splash -> Login/Register -> Chat List -> Chat`).
- `apps/thus_cli`: Dart console client with `/register`, `/login`, `/logout`, `/chats`, `/send`, `/listen`.

## EvoBase contract
Mặc định app dùng `http://127.0.0.1:3000` theo Postman collection.

- Auth:
  - `POST /auth/register`
  - `POST /auth/login`
  - `POST /auth/refresh`
- Messaging:
  - `GET /events` với `Authorization: Bearer <notification_token>`
  - `POST /messages/send` với `Authorization: Bearer <access_token>`
- REST gateway:
  - `GET/POST/PATCH/DELETE /rest/<table>`

Có thể override base URL bằng `THUS_BASE_URL`.

- CLI:
  ```bash
  THUS_BASE_URL=http://127.0.0.1:3000 dart run bin/thus_cli.dart
  ```
- Mobile:
  ```bash
  flutter run --dart-define=THUS_BASE_URL=http://10.0.2.2:3000
  ```

Lưu ý: Android emulator cần `10.0.2.2` thay vì `127.0.0.1`.

## Setup
```bash
dart pub get
dart pub get --directory packages/thus_core
dart pub get --directory packages/thus_storage
dart pub get --directory packages/thus_network
dart pub get --directory packages/thus_auth
dart pub get --directory packages/thus_messaging
dart pub get --directory apps/thus_cli
flutter pub get --directory apps/thus_mobile_app
dart run build_runner build --delete-conflicting-outputs --directory packages/thus_auth
dart run build_runner build --delete-conflicting-outputs --directory packages/thus_messaging
```

## Run
Mobile:
```bash
cd apps/thus_mobile_app
flutter run
```

CLI interactive:
```bash
cd apps/thus_cli
dart run bin/thus_cli.dart
```

CLI one-shot examples:
```bash
dart run bin/thus_cli.dart /register alice super-secret-password
dart run bin/thus_cli.dart /login alice super-secret-password
dart run bin/thus_cli.dart /listen
dart run bin/thus_cli.dart /send <target_user_id> "hello from thus"
dart run bin/thus_cli.dart /chats
```

## Notes
- Session local cache lưu `access_token`, `refresh_token`, `notification_token`, `user_id`, `username`.
- Message history hiện lấy từ Hive cache và từ SSE replay (`system.ready.replayed_messages`); Postman collection chưa mô tả endpoint lịch sử riêng cho chat.
- `very_good_analysis` đã được áp dụng cho toàn monorepo, với một vài rule ceremony-heavy được tắt ở mức project để giữ codebase thực dụng hơn.
- `flutter analyze` cho mobile và `dart analyze` cho các package/CLI đều đã sạch tại thời điểm refactor này.
