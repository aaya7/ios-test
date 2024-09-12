import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/repositories/auth_repositories/auth_repository.dart';
import 'package:hero/app/modules/main/controllers/main_controller.dart';

import '../../../core/services/http_services/http_services.dart';

class PersonalInfoController extends GetxController {
  final stateList = ["Johor", "Selangor"].obs;

  final cityList = ["Muar", "Petaling Jaya"].obs;

  final stateSelected = Rxn<String>();
  final citySelected = Rxn<String>();

  final bankList = [
    "MALAYAN BANKING BERHAD",
    "BANK ISLAM"
        "CIMB"
  ].obs;

  final bankSelected = Rxn<String>();

  var profilePicture = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> uploadProfilePhoto() async {
    try {
      if (profilePicture.value != null) {
        showLoading();
        dio.Response response = await AuthRepository.instance
            .uploadProfilePicture(avatar: profilePicture.value!);
        dismissDialog();
        snackBarSuccess(
            context: Get.context!, content: response.data["message"]);
        dismissBottomSheet();
        Get.find<MainController>().fetchProfile();
      } else {
        toastLong("Please upload one picture to proceed");
      }
    } catch (error, st) {
      log("xxx $error $st");
      dismissDialog();
      toastFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
    }
  }
}
