class ApiEndPoint {
  static const baseUrl = 'http://10.10.26.207:5002/api/v1';
  static const imageUrl = 'http://10.10.26.207:5002';
  static const socketUrl = 'http://10.10.26.207:5002';

  static const signUp = '/auth/signup';
  static const signIn = '/auth/login';
  static const verifyAccount = '/auth/verify-account';
  static const resendOtp = '/auth/resend-otp';
  static const verifyOtp = '/auth/verify-otp'; 
  static const createKycSession = '/auth/create-kyc-session';
  static const getProfile = '/user/me';
}
