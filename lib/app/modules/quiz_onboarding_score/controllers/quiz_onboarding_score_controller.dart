import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/quiz_onboarding_result_model.dart';

class QuizOnboardingScoreController extends GetxController {

  QuizOnboardingResultModel? result;

  late ConfettiController confettiController;

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null){
      result = Get.arguments["result"];
    }
    confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void onReady() {
    super.onReady();

    if(result?.isPassed ?? false){
      confettiController.play();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

}
