import 'package:get/get.dart';

import '../controllers/quiz_onboarding_score_controller.dart';

class QuizOnboardingScoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizOnboardingScoreController>(
      () => QuizOnboardingScoreController(),
    );
  }
}
