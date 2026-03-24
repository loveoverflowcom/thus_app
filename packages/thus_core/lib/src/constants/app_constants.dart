class AppConstants {
  const AppConstants._();

  static const defaultApiBaseUrl = String.fromEnvironment(
    'THUS_BASE_URL',
    defaultValue: 'http://127.0.0.1:3000',
  );

  // Auth
  static const authRegisterPath = '/auth/register';
  static const authLoginPath = '/auth/login';
  static const authRefreshPath = '/auth/refresh';

  // Messaging
  static const eventsPath = '/events';
  static const sendMessagePath = '/messages/send';

  // REST gateway tables
  static const restProfilesPath = '/rest/public.profiles';
  static const restContactRequestsPath = '/rest/public.contact_requests';
  static const restContactsPath = '/rest/public.contacts';

  // REST RPC
  static const rpcAcceptContactRequest =
      '/rest/public.rpc/accept_contact_request';
  static const rpcRejectContactRequest =
      '/rest/public.rpc/reject_contact_request';
  static const rpcRemoveContact = '/rest/public.rpc/remove_contact';

  // Storage
  static const hiveEncryptionKeyFileName = '.thus_hive_key';
}
