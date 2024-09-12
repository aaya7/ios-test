import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/repositories/auth_repositories/auth_repository.dart';

class ForgotPasswordController extends GetxController {
  final isLoading = false.obs;
  final emailTextController = TextEditingController();

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

  Future<void> forgotPassword() async {
    try {
      isLoading(true);

      showLoading();

      dio.Response response = await AuthRepository.instance
          .forgotPassword(email: emailTextController.text.trim());

      dismissDialog();
      isLoading(false);

      snackBarSuccess(context: Get.context!, content: response.data["message"]);

      Get.back();
    } catch (error, st) {
      isLoading(false);
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message
              : error.toString().removeException);
    }
  }
}
