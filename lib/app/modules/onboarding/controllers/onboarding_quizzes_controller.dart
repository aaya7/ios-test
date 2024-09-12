import 'dart:developer';

import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_onboarding_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_onboarding_quizes_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/quiz_onboarding_result_model.dart';
import 'package:hero/app/data/repositories/auth_repositories/register_checklist_repository.dart';
import 'package:hero/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:hero/app/routes/app_pages.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../assigned_job_details/controllers/assigned_job_details_controller.dart';

class OnboardingQuizzesController extends GetxController {
  final isLoading = false.obs;

  final quizModel = ChecklistOnboardingQuizzesModel().obs;

  String? assignmentUUID;
  String? quizUUID;

  YoutubePlayerController? youtubeController;

  String? title;

  final videoWatched = false.obs;

  bool isReadOnly = false;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments["assignment"] != null) {
        assignmentUUID = Get.arguments["assignment"];
      }

      if (Get.arguments["quiz"] != null) {
        quizUUID = Get.arguments["quiz"];
      }

      if (Get.arguments["title"] != null) {
        title = Get.arguments["title"];
      }

      if (Get.arguments["read_only"] != null) {
        isReadOnly = Get.arguments["read_only"];
      }
    }

    fetchOnboardingChecklist();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    youtubeController?.dispose();
  }

  bool isAllAnswered() {
    return (quizModel.value.onboardingQuiz?.quizzes ?? <Quiz>[]).isNotEmpty
        ? (quizModel.value.onboardingQuiz?.quizzes
                ?.every((element) => element.myAnswers!.value.isNotEmpty) ??
            false)
        : true;
  }

  int findIndexByAnswer(List<String> choices, String answer) {
    for (int x = 0; x < choices.length; x++) {
      if (choices[x] == answer) {
        return x;
      }
    }
    return -1;
  }

  Future<void> submitAnswers() async {
    try {
      showLoading();
      QuizOnboardingResultModel result = await RegisterChecklistRepository.instance
          .submitQuizAnswer(
              assignmentUUID: assignmentUUID ?? '',
              quizUUID: quizUUID ?? '',
              quiz: quizModel.value.onboardingQuiz!);
      dismissDialog();

      snackBarSuccess(context: Get.context!, content: "Answered quiz submit successfully");

      Get.find<OnboardingController>().fetchOnboardingChecklist();
      if(result.isPassed ?? false){
        Get.find<OnboardingController>().isReadOnly = true;
      }
      Get.find<AssignedJobDetailsController>().fetchJobDetail();
      Get.offNamed(Routes.QUIZ_ONBOARDING_SCORE, arguments: {
        "result":result
      });
    } catch (error, st) {
      dismissDialog();
      log("xxx $error $st");
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
    }
  }

  Future<void> fetchOnboardingChecklist() async {
    try {
      isLoading(true);

      quizModel(await RegisterChecklistRepository.instance.getOnboardingQuizzes(
          assignmentUUID: assignmentUUID ?? '', quizUUID: quizUUID ?? ''));

      if(isReadOnly){
        for(var item in quizModel.value.onboardingQuiz?.quizzes ?? <Quiz>[]){
          item.myAnswers?.value = (item.choices ?? <String>[]).elementAt(item.answer ?? 0);
        }
      }

      String? videoId;
      videoId =
          YoutubePlayer.convertUrlToId(quizModel.value.onboardingVideo ?? '');
      log("xxx youtube id $videoId");

      youtubeController = YoutubePlayerController(
          initialVideoId: videoId ?? '',
          flags: const YoutubePlayerFlags(autoPlay: false));

      isLoading(false);
    } catch (error, st) {
      isLoading(false);
      log("xxx fetch onboarding $error $st");
    }
  }
}
