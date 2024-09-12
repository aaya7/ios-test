import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/text_field.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/routes/app_pages.dart';

import '../../../core/widgets/welcome_body.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      body: WelcomeBody(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                (height * 0.3).height,
                Image.asset(
                  "assets/images/carpedia_logo.png",
                  width: width * 0.4,
                ),
                20.0.height,
                SizedBox(
                  width: width * 0.5,
                  child: Text(
                    "Take the next step to generate income by doing gigs with us".tr,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.black54, fontSize: 17),
                  ),
                ),
                25.0.height,
                CommonTextField(
                  hintText: "Your email".tr,
                  title: "Email".tr,
                  isValidationRequired: false,
                  textEditingController: controller.emailTextController,
                  type: TextFieldType.EMAIL,
                ),
                10.0.height,
                CommonTextField(
                  hintText: "Enter password".tr,
                  title: "Password".tr,
                  isValidationRequired: false,
                  textEditingController: controller.passwordTextController,
                  type: TextFieldType.PASSWORD,
                ),
                10.0.height,
                Row(
                  children: [
                    Text(
                      "Forgot your password?".tr,
                      style: context.textTheme.headline6!
                          .copyWith(color: ColorConstant.primaryColor),
                    ).onTap(() {
                      Get.toNamed(Routes.FORGOT_PASSWORD);
                    }),
                  ],
                ),
                20.0.height,
                Obx(() {
                  return controller.isLoading.isTrue
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CommonButton(
                          title: "Login".tr,
                          callBack: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.login();
                            }
                          });
                }),
                20.0.height,
                // Row(
                //   children: [
                //     Expanded(
                //         child: Container(
                //       color: Colors.grey,
                //       height: 0.4,
                //     )),
                //     Text(
                //       "or",
                //       style: context.textTheme.headline6!
                //           .copyWith(color: Colors.black54),
                //     ).paddingSymmetric(horizontal: 20),
                //     Expanded(
                //         child: Container(
                //       color: Colors.grey,
                //       height: 0.4,
                //     )),
                //   ],
                // ),
                // 20.0.height,
                // CommonButton(
                //   title: "Login with Google",
                //   callBack: () {},
                //   imageIcon: "assets/images/google.png",
                //   border: Colors.grey[400],
                //   buttonTextColor: Colors.black54,
                //   buttonColor: Colors.grey[100],
                // ),
                // 10.0.height,
                // CommonButton(
                //   title: "Login with Facebook",
                //   callBack: () {},
                //   imageIcon: "assets/images/fb.png",
                //   border: Colors.grey[400],
                //   buttonTextColor: Colors.black54,
                //   buttonColor: Colors.grey[100],
                // ),
                // 10.0.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?".tr,
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.grey),
                    ),
                    Text(
                      " " + "Sign Up".tr,
                      style: context.textTheme.headline3!
                          .copyWith(color: ColorConstant.primaryColor),
                    )
                  ],
                ).onTap(() => Get.toNamed(Routes.REGISTER))
              ],
            ).paddingSymmetric(horizontal: width * 0.04),
          ),
        ),
      ),
    );
  }
}
