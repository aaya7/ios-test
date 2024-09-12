import 'package:get/get.dart';

import '../controllers/sign_in_security_controller.dart';

class SignInSecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInSecurityController>(
      () => SignInSecurityController(),
    );
  }
}
