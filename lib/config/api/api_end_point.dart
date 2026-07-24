class ApiEndPoint {
  static const baseUrl = 'https://fahim5002.naimulhassan.me/api/v1';
  static const imageUrl = 'https://fahim5002.naimulhassan.me';
  static const socketUrl = 'https://fahim5002.naimulhassan.me';
  static const chatUrl = '$socketUrl/chat';
  static const signUp = '/auth/signup';
  static const signIn = '/auth/login';
  static const logout = '/auth/logout';
  static const verifyAccount = '/auth/verify-account';
  static const resendOtp = '/auth/resend-otp';
  static const verifyOtp = '/auth/verify-otp';
  static const createKycSession = '/auth/create-kyc-session';
  static const getProfile = '/user/me';
  static const updateProfile = '/user/profile';
  static const dashboardSummary = '/user/dashboard';
  // Stripe Endpoints
  static const stripeAccountStatus = '/stripe/account-status';
  static const stripeConnectAccount = '/stripe/connect-account';
  static const createGroup = '/group/create';
  static const getMyGroups = '/group/my-groups';
  static const getAllGroups = '/group';
  static const joinGroup = '/group/join/';
  static const startGroup = '/group/start/';
  static const payGroup = '/group/pay/';
  static const sendInvitation = '/group-invitation/send';
  static const myInvitations = '/group-invitation/my-invitations';
  static const respondInvitation = '/group-invitation/respond/';
  static const groupPeriodHistory = '/group/period-history/';
  static const groupMessage = '/group-message/';
  static const contributionHistory = '/contribution/history';
  static const contributionOutstanding = '/contribution/outstanding';
  static const faqAll = '/public/faq/all';
  static const privacyPolicy = '/public/privacy-policy';
  static const termsAndCondition = '/public/terms-and-condition';
}
