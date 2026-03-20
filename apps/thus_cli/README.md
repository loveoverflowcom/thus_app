# thus_cli

`thus_cli` là CLI client cho Thus Chat. Bạn có thể dùng nó để đăng ký tài khoản, đăng nhập, gửi tin nhắn, xem hội thoại đã cache cục bộ và nghe tin nhắn realtime qua SSE.

## Chạy CLI

Từ thư mục monorepo:

```bash
dart pub get --directory apps/thus_cli
cd apps/thus_cli
dart run bin/thus_cli.dart
```

Mặc định CLI dùng backend `http://127.0.0.1:3000`. Nếu cần đổi sang server khác, set biến môi trường `THUS_BASE_URL`:

```bash
THUS_BASE_URL=http://127.0.0.1:3000 dart run bin/thus_cli.dart
```

## Xem help

CLI hỗ trợ help tổng và help cho từng lệnh:

```bash
dart run bin/thus_cli.dart --help
dart run bin/thus_cli.dart -h
dart run bin/thus_cli.dart help /send
dart run bin/thus_cli.dart /send --help
```

Trong interactive shell, bạn cũng có thể dùng:

```text
help
/help
help /login
/login --help
```

## Hai cách dùng

### 1. Interactive shell

Chạy không truyền tham số:

```bash
dart run bin/thus_cli.dart
```

CLI sẽ hiện prompt `thus>`. Từ đây bạn có thể nhập từng lệnh như:

```text
/register alice super-secret-password
/login alice super-secret-password
/chats
/send <target_user_id> hello from thus
/listen
/exit
```

### 2. One-shot command

Bạn có thể chạy một lệnh rồi thoát ngay:

```bash
dart run bin/thus_cli.dart /register alice super-secret-password
dart run bin/thus_cli.dart /login alice super-secret-password
dart run bin/thus_cli.dart /send <target_user_id> "hello from thus"
dart run bin/thus_cli.dart /chats
dart run bin/thus_cli.dart /chats <conversation_id>
dart run bin/thus_cli.dart /listen
```

## Danh sách lệnh

### `/register <username> <password>`

Tạo tài khoản mới và lưu session cục bộ nếu thành công.

### `/login <username> <password>`

Đăng nhập bằng tài khoản có sẵn và lưu session cục bộ.

### `/logout`

Xóa session cục bộ đang lưu.

### `/chats [conversation_id]`

- Không truyền tham số: in danh sách chat đang có trong local cache.
- Có `conversation_id`: in tối đa 20 tin nhắn gần nhất của hội thoại đó từ local cache.

### `/send <target_user_id> <message>`

Gửi một tin nhắn đến user đích. Lệnh này yêu cầu đã đăng nhập trước.

### `/listen`

Mở kết nối SSE và in tin nhắn đến cho đến khi bạn dừng bằng `Ctrl+C`.

## Lưu ý

- Dữ liệu local của CLI được lưu ở `~/.thus_cli`.
- `/send` cần access token đã lưu trước đó, nên thường bạn sẽ chạy `/login` trước.
- `/listen` giữ process chạy liên tục để stream sự kiện mới.
