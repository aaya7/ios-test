import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/repositories/auth_repositories/auth_repository.dart';
import 'package:hero/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if(kDebugMode){
      emailTextController.text = "hidayahkai@gmail.com";
      passwordTextController.text = "yaya1234";
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> login() async {
    try {
      isLoading(true);
      await AuthRepository.instance.login(
          email: emailTextController.text,
          password: passwordTextController.text);

      snackBarSuccess(context: Get.context!, content: "Login success");

      Get.offAllNamed(Routes.MAIN);
    } catch (error) {
      snackBarFailed(
          context: Get.context!,
          content: error is CustomException
              ? error.message.removeException
              : error.toString().removeException);
    }finally{
      isLoading(false);
    }
  }
}
