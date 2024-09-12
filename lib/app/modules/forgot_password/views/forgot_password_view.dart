import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:line_icons/line_icons.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Forgot Password"),
      body: SizedBox(
        width: width,
        child: Column(
          children: [
            40.0.height,
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 0.4)),
              child: const Icon(
                LineIcons.key,
                color: ColorConstant.textPrimaryColor,
                size: 30,
              ),
            ),
            20.0.height,
            Text(
              "Forgotten your Password?",
              style: context.textTheme.headline2!.copyWith(fontSize: 22),
            ),
            10.0.height,
            Text(
              "We’ll send you a reset link if your account exists",
              style: context.textTheme.headline6!
                  .copyWith(color: Colors.grey, fontSize: 15),
            ),
            20.0.height,
            const Row(
              children: [
                Text("Email"),
              ],
            ),
            10.0.height,
            CommonTextField(
              hintText: "Your Email",
              title: "Email",
              textEditingController: controller.emailTextController,
            ),
            20.0.height,
            Obx(() {
              return controller.isLoading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: ColorConstant.primaryColor,
                      ),
                    )
                  : CommonButton(
                      title: "Reset my Password",
                      callBack: () {
                        controller.forgotPassword();
                      });
            }),
            10.0.height,
            CommonButton(
              title: "Cancel",
              callBack: () {
                Get.back();
              },
              border: Colors.grey[400],
              buttonTextColor: Colors.black54,
              buttonColor: Colors.grey[100],
            ),
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}
