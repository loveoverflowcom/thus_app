class AppConstants {
  const AppConstants._();

  static const defaultApiBaseUrl = String.fromEnvironment(
    'THUS_BASE_URL',
    defaultValue: 'http://127.0.0.1:3000',
  );
  static const authRegisterPath = '/auth/register';
  static const authLoginPath = '/auth/login';
  static const authRefreshPath = '/auth/refresh';
  static const eventsPath = '/events';
  static const sendMessagePath = '/messages/send';
  static const hiveEncryptionKeyFileName = '.thus_hive_key';
}
