class ApiEndPoint {
  static const baseUrl = 'http://10.10.26.207:5002/api/v1';
  static const imageUrl = 'http://10.10.26.207:5002';
  static const socketUrl = 'http://10.10.26.207:5002';
  static const signUp = '/auth/signup';
  static const signIn = '/auth/login';
  static const logout = '/auth/logout';
  static const verifyAccount = '/auth/verify-account';
  static const resendOtp = '/auth/resend-otp';
  static const verifyOtp = '/auth/verify-otp';
  static const createKycSession = '/auth/create-kyc-session';
  static const getProfile = '/user/me';
  // Stripe Endpoints
  static const stripeAccountStatus = '/stripe/account-status';
  static const stripeConnectAccount = '/stripe/connect-account';
  static const createGroup = '/group/create';
  static const getMyGroups = '/group/my-groups';
  static const getAllGroups = '/group';
  static const joinGroup = '/group/join/'; 
  static const startGroup = '/group/start/';
  static const groupPeriodHistory = '/group/period-history/';
}
