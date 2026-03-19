import 'package:test/test.dart';
import 'package:thus_messaging/thus_messaging.dart';

void main() {
  group('SendMessageParams', () {
    test('keeps target and content', () {
      const SendMessageParams params = SendMessageParams(
        toUserId: 'user-2',
        content: 'hello',
        source: 'test',
      );

      expect(params.toUserId, 'user-2');
      expect(params.content, 'hello');
      expect(params.source, 'test');
    });
  });
}
