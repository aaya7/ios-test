import 'dart:developer';

import 'package:get/get.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_onboarding_model.dart';
import 'package:hero/app/data/repositories/auth_repositories/register_checklist_repository.dart';

class OnboardingController extends GetxController {
  final isLoading = false.obs;

  final onboardingChecklist = <ChecklistOnboardingModel>[].obs;

  String? assignmentUUID;

  bool isReadOnly = false;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments["assignment"] != null) {
        assignmentUUID = Get.arguments["assignment"];
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
  }

  Future<void> fetchOnboardingChecklist() async {
    try {
      isLoading(true);

      onboardingChecklist(await RegisterChecklistRepository.instance
          .getOnboardingChecklist(assignmentUUID: assignmentUUID ?? ''));

      isLoading(false);
    } catch (error, st) {
      isLoading(false);
      log("xxx fetch onboarding $error $st");
    }
  }
}
