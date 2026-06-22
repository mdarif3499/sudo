import 'package:get/get.dart';
import '../../auth/screen/doc_submitted_screen.dart';
import '../../profile/screen/subscription_screen.dart';
import '../../profile/screen/terms_condition.dart';
import '../../splash/mmu_bylaws_screen.dart';
import '../../splash/splash_screen.dart';
import '../../onboarding/onboarding_screen.dart';
import '../../auth/screen/auth_screen.dart';
import '../../auth/screen/login_screen.dart';
import '../../auth/screen/register_screen.dart';
import '../../auth/screen/kyc_screen.dart';
import '../../auth/screen/forgot_password_screen.dart';
import '../../auth/screen/reset_password_screen.dart';
import '../../auth/screen/success_screen.dart';
import '../../component/bottom_nav_bar/main_screen.dart';
import '../../profile/screen/edit_profile_screen.dart';
import '../../profile/screen/payment_method_screen.dart';
import '../../profile/screen/change_password_screen.dart';
import '../../profile/screen/faq_screen.dart';
import '../../profile/screen/help_support_screen.dart';
import '../../profile/screen/privacy_policy_screen.dart';
import '../../home/screen/notification_screen.dart';
import '../../home/screen/create_group_screen.dart';
import '../../groups/view/group_details_screen.dart';
import '../../groups/view/invite_members_screen.dart';
import '../../groups/view/chat_screen.dart';
import '../../groups/view/make_payment_screen.dart';
import '../../groups/view/review_payment_screen.dart';
import '../../auth/screen/otp_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String onboardingResturent = '/onboardingResturent';
  static const String auth = '/auth';
  static const String login = '/login';
  static const String register = '/register';
  static const String kyc = '/kyc';
  static const String docSubmitted = '/docSubmitted';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgotPassword';
  static const String resetPassword = '/resetPassword';
  static const String success = '/success';
  static const String main = '/main';
  static const String editProfile = '/editProfile';
  static const String paymentMethod = '/paymentMethod';
  static const String changePassword = '/changePassword';
  static const String faq = '/faq';
  static const String helpSupport = '/helpSupport';
  static const String privacyPolicy = '/privacyPolicy';
  static const String termsCondition = '/termsCondition';
  static const String subscriptionScreen = '/subscriptionScreen';
  static const String notification = '/notification';
  static const String createGroup = '/createGroup';
  static const String groupDetails = '/groupDetails';
  static const String inviteMembers = '/inviteMembers';
  static const String chat = '/chat';
  static const String makePayment = '/makePayment';
  static const String reviewPayment = '/reviewPayment';

  static const String mmuBylawsScreen = '/mmuBylawsScreen';

  static List<GetPage<String>> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: auth, page: () => const AuthScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: kyc, page: () => KycScreen()),
    GetPage(name: docSubmitted, page: () => const DocSubmittedScreen()),
    GetPage(name: otp, page: () => const OtpScreen()),
    GetPage(name: forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(name: success, page: () => const SuccessScreen()),
    GetPage(name: main, page: () => NavbarScreen()),
    GetPage(name: editProfile, page: () => const EditProfileScreen()),
    GetPage(name: paymentMethod, page: () => const PaymentMethodScreen()),
    GetPage(name: changePassword, page: () => const ChangePasswordScreen()),
    GetPage(name: faq, page: () => const FaqScreen()),
    GetPage(name: helpSupport, page: () => const HelpSupportScreen()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: termsCondition, page: () => const TermsCondition()),
    GetPage(name: subscriptionScreen, page: () => const SubscriptionScreen()),
    GetPage(name: notification, page: () => const NotificationScreen()),
    GetPage(name: createGroup, page: () => const CreateGroupScreen()),
    GetPage(name: groupDetails, page: () => const GroupDetailsScreen()),
    GetPage(name: inviteMembers, page: () => InviteMembersScreen()),
    GetPage(name: chat, page: () => ChatScreen()),
    GetPage(name: makePayment, page: () => const MakePaymentScreen()),
    GetPage(name: reviewPayment, page: () => const ReviewPaymentScreen()),
    GetPage(name: mmuBylawsScreen, page: () => const MmuBylawsScreen()),
  ];
}
