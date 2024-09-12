import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/text_field.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/routes/app_pages.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/widgets/common_appbar.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/common_textfield.dart';
import '../../../data/constants/color_constant.dart';
import '../controllers/sign_in_security_controller.dart';

class SignInSecurityView extends GetView<SignInSecurityController> {
  const SignInSecurityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Sign In & Security".tr),
      body: SizedBox(
        width: width,
        child: Column(
          children: [
            40.0.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[400]!)),
                  child: Icon(
                    FontAwesomeIcons.shieldHalved,
                    color: Colors.black54,
                    size: 18,
                  ),
                ),
                20.0.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign In & Security".tr,
                        style:
                            context.textTheme.headline3!.copyWith(fontSize: 20),
                      ),
                      Text(
                        "Adjust your sign in and security access.".tr,
                        style:
                            context.textTheme.headline6!.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            50.0.height,
             Row(
              children: [
                Text("Password".tr),
              ],
            ),
            10.0.height,
            CommonTextField(
              hintText: "Password".tr,
              title: "Password".tr,
              type: TextFieldType.PASSWORD,
            ),
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonButton(
            title: "Reset My Password".tr,
            callBack: () {},
            buttonColor: Colors.white,
            buttonTextColor: ColorConstant.primaryColor,
            border: Colors.grey[500],
          ),
          TextButton(
              onPressed: () {
                Get.toNamed(Routes.FORGOT_PASSWORD);
              },
              child: Text(
                "Forgot Password".tr,
                style:
                    context.textTheme.headline3!.copyWith(color: Colors.black),
              ))
        ],
      ).paddingSymmetric(horizontal: width * 0.04, vertical: 20),
    );
  }
}
