import 'package:get/get.dart';
import '../../profile/screen/subscription_screen.dart';
import '../../profile/screen/terms_condition.dart';
import '../../splash/mmu_bylaws_screen.dart';
import '../../splash/splash_screen.dart';
import '../../onboarding/onboarding_screen.dart';
import '../../auth/auth_screen.dart';
import '../../auth/login_screen.dart';
import '../../auth/register_screen.dart';
import '../../auth/kyc_screen.dart';
import '../../auth/forgot_password_screen.dart';
import '../../auth/reset_password_screen.dart';
import '../../auth/success_screen.dart';
import '../../component/bottom_nav_bar/main_screen.dart';
import '../../profile/screen/edit_profile_screen.dart';
import '../../profile/screen/payment_method_screen.dart';
import '../../profile/screen/change_password_screen.dart';
import '../../profile/screen/faq_screen.dart';
import '../../profile/screen/help_support_screen.dart';
import '../../profile/screen/privacy_policy_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String login = '/login';
  static const String register = '/register';
  static const String kyc = '/kyc';
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

  static const String mmuBylawsScreen = '/mmuBylawsScreen';

  static List<GetPage<String>> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: auth, page: () => const AuthScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: kyc, page: () => const KycScreen()),
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

    GetPage(name: mmuBylawsScreen, page: () => const MmuBylawsScreen()),
  ];
}
