import 'package:get/get.dart';
import 'package:hero/app/modules/onboarding/controllers/onboarding_quizzes_controller.dart';

class OnboardingQuizzesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingQuizzesController>(
          () => OnboardingQuizzesController(),
    );
  }
}
