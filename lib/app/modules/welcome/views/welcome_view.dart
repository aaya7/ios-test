import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/language/bottomsheet_choose_lang.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/routes/app_pages.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/widgets/welcome_body.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      body: WelcomeBody(
        child: Column(
          children: [
            SizedBox(
              height: (height * 0.3),
              width: width,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black54)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            LineIcons.globe,
                            color: Colors.black54,
                          ),
                          5.0.width,
                          Text(
                            LocalDBService.instance.getLanguage(),
                            style: context.textTheme.headline3!
                                .copyWith(color: Colors.black54),
                          )
                        ],
                      ),
                    ).onTap(() {
                      showChooseLangBottomSheet();
                    }),
                  ),
                ],
              ),
            ),
            Image.asset(
              "assets/images/carpedia_logo.png",
              width: width * 0.4,
            ),
            20.0.height,
            SizedBox(
              width: width * 0.5,
              child: Text(
                "Take the next step to generate income by doing gigs with us"
                    .tr,
                textAlign: TextAlign.center,
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54, fontSize: 17),
              ),
            ),
            const Spacer(),
            25.0.height,
            CommonButton(
              title: "Sign Up".tr,
              callBack: () => Get.toNamed(Routes.REGISTER),
              iconData: Icons.person,
            ),
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
            //   title: "Sign Up with Google",
            //   callBack: () {},
            //   imageIcon: "assets/images/google.png",
            //   border: Colors.grey[400],
            //   buttonTextColor: Colors.black54,
            //   buttonColor: Colors.grey[100],
            // ),
            // 10.0.height,
            // CommonButton(
            //   title: "Sign Up with Facebook",
            //   callBack: () {},
            //   imageIcon: "assets/images/fb.png",
            //   border: Colors.grey[400],
            //   buttonTextColor: Colors.black54,
            //   buttonColor: Colors.grey[100],
            // ),
            10.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a driver?".tr,
                  style:
                      context.textTheme.headline6!.copyWith(color: Colors.grey),
                ),
                Text(
                  " " + "Log In".tr,
                  style: context.textTheme.headline3!
                      .copyWith(color: ColorConstant.primaryColor),
                )
              ],
            ).onTap(() => Get.toNamed(Routes.LOGIN)),
            (Get.height * 0.2).height,
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "By signing up, you agree to our".tr + " ",
          //       style:
          //           context.textTheme.headline6!.copyWith(color: Colors.grey),
          //     ),
          //     Text(
          //       "Terms and Conditions".tr,
          //       style: context.textTheme.headline6!.copyWith(
          //           color: ColorConstant.primaryColor,
          //           decoration: TextDecoration.underline),
          //     )
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "Learn how we use your data in our".tr + " ",
          //       style:
          //       context.textTheme.headline6!.copyWith(color: Colors.grey),
          //     ),
          //     Expanded(
          //       child: Text(
          //         "Privacy Policy".tr,
          //         style: context.textTheme.headline6!.copyWith(
          //             color: ColorConstant.primaryColor,
          //             decoration: TextDecoration.underline),
          //       ),
          //     )
          //   ],
          // ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "By signing up, you agree to our".tr + " ",
                  style:
                      context.textTheme.headline6!.copyWith(color: Colors.grey),
                ),
                TextSpan(
                  text: "Terms and Conditions".tr,
                  style: context.textTheme.headline6!
                      .copyWith(color: ColorConstant.primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Implement the action to open the Privacy Notice here.
                      print('Privacy Notice tapped');
                    },
                ),
                TextSpan(
                  text: " " + "Learn how we use your data in our".tr + " ",
                  style:
                      context.textTheme.headline6!.copyWith(color: Colors.grey),
                ),
                TextSpan(
                  text: "Privacy Policy".tr,
                  style: context.textTheme.headline6!
                      .copyWith(color: ColorConstant.primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Implement the action to open the Terms and Conditions here.
                      print('Terms and Conditions tapped');
                    },
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: width * 0.04),
          20.0.height,
        ],
      ),
    );
  }
}
