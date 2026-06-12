class ApiEndPoint {
  // static const baseUrl = 'http://10.10.7.39:5005/api/v1';
  // static const imageUrl = 'http://10.10.7.39:5005';
  // static const socketUrl = 'http://10.10.7.39:5005';

  static const baseUrl = 'https://rakibur5005.binarybards.online/api/v1';
  static const imageUrl = 'https://rakibur5005.binarybards.online';
  static const socketUrl = 'https://rakibur5005.binarybards.online';

  static const signUp = 'users/sign-up';
  static const verifyEmail = 'users/verify-email';
  static const signIn = '/auth/login';
  static const googleSignIn = '/auth/google'; // Added for Google Login
  static const forgotPassword = '/auth/forget-password';
  static const resendOtp = '/auth/resend-otp';
  static const verifyOtp = '/auth/verify-otp';
  static const resetPassword = '/auth/reset-password';
  static const changePassword = '/auth/change-password';
  static const user = 'users';
  static const profile = '/users/profile';
  static const getMe = '/users/me';
  static const deleteAccount = '/users/delete/account';
  static const dependents = '/dependents';
  static const createDependent = '/dependents/create';
  static String updateDependent(String id) => '/dependents/update/$id';
  static const events = '/events';
  static const eventTypes = '/event-types/public';
  static const createEventReport = '/event-reports/create';
  static const notifications = 'notifications';
  static const privacyPolicies = 'privacy-policies';
  static const termsOfServices = 'terms-and-conditions';
  static const chats = 'chats';
  static const messages = 'messages';
  static const faqs = '/faqs';
  static const faqsPublic = '/faqs/public';
  static const settings = '/settings';
  static const notificationPreferences = '/notification-preferences';
  static const paymentBreakdown = '/wallet/payment-breakdown';
  static const checkoutPenalties = '/payments/checkout/penalties';
  static const checkoutContributions = '/payments/checkout/contributions';
}
