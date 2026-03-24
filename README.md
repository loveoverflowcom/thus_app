# Thus Chat Monorepo

Monorepo cho client chat kiểu WhatsApp chạy trên EvoBase API, gồm Flutter mobile app, Dart CLI, và các package domain dùng chung.

## Structure
- `packages/thus_core`: constants, logger, failure, use case primitives.
- `packages/thus_storage`: Hive CE bootstrap, persisted encryption key, generic JSON cache repository.
- `packages/thus_auth`: EvoBase auth session (`/auth/register`, `/auth/login`, `/auth/refresh`), local session store, `AuthBloc`.
- `packages/thus_network`: Dio REST client, SSE parser/client, optional WebSocket client.
- `packages/thus_contacts`: Profiles, ContactRequests, Contacts domain — REST gateway calls, `ContactsBloc`, `ProfileBloc`.
- `packages/thus_messaging`: message/chat entities, local history cache, `/messages/send`, `/events` SSE subscription, `ChatBloc`.
- `apps/thus_mobile_app`: Flutter UI (`Splash -> Login/Register -> Chat List -> Chat | Contacts | Personal -> Profile`).
- `apps/thus_cli`: Dart console client with `/register`, `/login`, `/logout`, `/profile`, `/contacts`, `/chats`, `/send`, `/listen`.

## EvoBase contract
Mặc định app dùng `http://127.0.0.1:3000` theo Postman collection.

- Auth:
  - `POST /auth/register`
  - `POST /auth/login`
  - `POST /auth/refresh`
- Profiles:
  - `GET /rest/public.profiles?user_id=eq.<id>&select=...`
  - `PATCH /rest/public.profiles?user_id=eq.<id>`
- Contact Requests:
  - `POST /rest/public.contact_requests`
  - `GET /rest/public.contact_requests?to_user=eq.<id>&status=eq.pending`
  - `POST /rest/public.rpc/accept_contact_request`
  - `POST /rest/public.rpc/reject_contact_request`
  - `DELETE /rest/public.contact_requests?id=eq.<id>&status=eq.pending`
- Contacts:
  - `GET /rest/public.contacts?user_id=eq.<id>`
  - `POST /rest/public.rpc/remove_contact`
- Messaging:
  - `GET /events` với `Authorization: Bearer <notification_token>`
  - `POST /messages/send` với event types: `chat.message`, `chat.typing`, `chat.read`, `contact.request`, `contact.accepted`

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
dart pub get --directory packages/thus_contacts
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

CLI help:
```bash
dart run bin/thus_cli.dart --help
dart run bin/thus_cli.dart help /contacts
```

CLI one-shot examples:
```bash
dart run bin/thus_cli.dart /register alice super-secret-password
dart run bin/thus_cli.dart /login alice super-secret-password
dart run bin/thus_cli.dart /profile
dart run bin/thus_cli.dart /profile "Alice Nguyen" "Flutter dev"
dart run bin/thus_cli.dart /contacts
dart run bin/thus_cli.dart /contacts search ali
dart run bin/thus_cli.dart /contacts add <target_user_id>
dart run bin/thus_cli.dart /contacts accept <request_id>
dart run bin/thus_cli.dart /contacts remove <user_id>
dart run bin/thus_cli.dart /listen
dart run bin/thus_cli.dart /send <target_user_id> "hello from thus"
dart run bin/thus_cli.dart /chats
```

## Notes
- Session local cache lưu `access_token`, `refresh_token`, `notification_token`, `user_id`, `username`.
- `thus_contacts` không dùng code generation (freezed/json_serializable) — plain Dart classes với `fromJson`/`toJson` thủ công.
- SSE hỗ trợ các event types: `chat.message`, `chat.typing`, `chat.read`, `contact.request`, `contact.accepted`, `system.ready`.
- Chỉ `chat.message` được lưu vào local cache; các event ephemeral khác chỉ được stream qua `events`.
- `very_good_analysis` đã được áp dụng cho toàn monorepo.
