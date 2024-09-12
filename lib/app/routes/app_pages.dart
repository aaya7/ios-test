import 'package:get/get.dart';

import '../modules/account_management/bindings/account_management_binding.dart';
import '../modules/account_management/views/account_management_view.dart';
import '../modules/assigned_job_details/bindings/assigned_job_details_binding.dart';
import '../modules/assigned_job_details/views/assigned_job_details_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/job_details/bindings/job_details_binding.dart';
import '../modules/job_details/views/job_details_view.dart';
import '../modules/jobs/bindings/jobs_binding.dart';
import '../modules/jobs/views/jobs_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/messages/bindings/messages_binding.dart';
import '../modules/messages/views/messages_view.dart';
import '../modules/notification_detail/bindings/notification_detail_binding.dart';
import '../modules/notification_detail/views/notification_detail_view.dart';
import '../modules/notification_setting/bindings/notification_setting_binding.dart';
import '../modules/notification_setting/views/notification_setting_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/personal_info/bindings/personal_info_binding.dart';
import '../modules/personal_info/views/personal_info_view.dart';
import '../modules/pod_detail/bindings/pod_detail_binding.dart';
import '../modules/pod_detail/views/pod_detail_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/quiz_onboarding_score/bindings/quiz_onboarding_score_binding.dart';
import '../modules/quiz_onboarding_score/views/quiz_onboarding_score_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/register_checklist/bindings/register_checklist_binding.dart';
import '../modules/register_checklist/views/register_checklist_view.dart';
import '../modules/sign_in_security/bindings/sign_in_security_binding.dart';
import '../modules/sign_in_security/views/sign_in_security_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';
import '../modules/work_preference/bindings/work_preference_binding.dart';
import '../modules/work_preference/views/work_preference_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.JOBS,
      page: () => const JobsView(),
      binding: JobsBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGES,
      page: () => const MessagesView(),
      binding: MessagesBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.JOB_DETAILS,
      page: () => const JobDetailsView(),
      binding: JobDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ASSIGNED_JOB_DETAILS,
      page: () => const AssignedJobDetailsView(),
      binding: AssignedJobDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO,
      page: () => const PersonalInfoView(),
      binding: PersonalInfoBinding(),
    ),
    GetPage(
      name: _Paths.WORK_PREFERENCE,
      page: () => const WorkPreferenceView(),
      binding: WorkPreferenceBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN_SECURITY,
      page: () => const SignInSecurityView(),
      binding: SignInSecurityBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_MANAGEMENT,
      page: () => const AccountManagementView(),
      binding: AccountManagementBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SETTING,
      page: () => const NotificationSettingView(),
      binding: NotificationSettingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_CHECKLIST,
      page: () => const RegisterChecklistView(),
      binding: RegisterChecklistBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.POD_DETAIL,
      page: () => const PodDetailView(),
      binding: PodDetailBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ_ONBOARDING_SCORE,
      page: () => const QuizOnboardingScoreView(),
      binding: QuizOnboardingScoreBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_DETAIL,
      page: () => const NotificationDetailView(),
      binding: NotificationDetailBinding(),
    ),
  ];
}
