import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_dropdown_widget.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/core/widgets/text_field.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: ""),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/register_asset.png",
                    height: 150,
                    width: width,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                20.0.height,
                Text(
                  "New Registration".tr,
                  style: context.textTheme.headline2,
                ),
                Text(
                  "Tell me about yourself".tr,
                  style: context.textTheme.headline6!.copyWith(
                    color: Colors.grey,
                  ),
                ),
                20.0.height,
                Text(
                  "Name".tr,
                ),
                10.0.height,
                CommonTextField(
                  hintText: "Your name".tr,
                  title: "Name".tr,
                  textEditingController: controller.nameTextController,
                  type: TextFieldType.NAME,
                ),
                20.0.height,
                Text(
                  "Email".tr,
                ),
                10.0.height,
                CommonTextField(
                  hintText: "Email".tr,
                  title: "Email".tr,
                  textEditingController: controller.emailTextController,
                ),
                20.0.height,
                Text(
                  "Mobile Number".tr,
                ),
                10.0.height,
                CommonTextField(
                  hintText: "",
                  title: "Mobile Number".tr,
                  textEditingController: controller.mobileTextController,
                  prefixIconData: LayoutBuilder(builder: (context, constraint) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (constraint.maxWidth * 0.03).width,
                        Text(
                          "+60",
                          style: context.textTheme.headline6!
                              .copyWith(color: Colors.black54),
                        ),
                        (constraint.maxWidth * 0.03).width,
                        Container(
                          height: 50,
                          width: 0.5,
                          color: Colors.grey,
                        )
                      ],
                    );
                  }),
                ),
                20.0.height,
                Text("Preferred Location".tr),
                10.0.height,
                Row(
                  children: [
                    Expanded(
                      child: CommonDropdownWidget(
                          selectedValue: controller.stateSelected,
                          dropdownList: controller.stateList,
                          title: "State".tr,
                          hintText: "State".tr,
                          onChanged: (_) {
                            controller.stateSelected.value = _;
                            controller.citySelected.value = null;
                            controller.fetchCities(state: _);
                          },
                          displayItem: ""),
                    ),
                    10.0.width,
                    Expanded(
                      child: CommonDropdownWidget(
                          selectedValue: controller.citySelected,
                          dropdownList: controller.cityList,
                          title: "City".tr,
                          hintText: "City".tr,
                          onChanged: (_) {
                            controller.citySelected.value = _;
                          },
                          displayItem: "name"),
                    ),
                  ],
                ),
                20.0.height,
                Text(
                  "Password".tr,
                ),
                10.0.height,
                CommonTextField(
                  hintText: "Enter password".tr,
                  title: "Password".tr,
                  textEditingController: controller.passwordTextController,
                  type: TextFieldType.PASSWORD,
                ),
                20.0.height,
                Text(
                  "Confirm Password".tr,
                ),
                10.0.height,
                CommonTextField(
                  hintText: "Reenter password again".tr,
                  title: "Confirm Password".tr,
                  type: TextFieldType.PASSWORD,
                  textEditingController:
                      controller.confirmPasswordTextController,
                ),
                20.0.height,
                Text(
                  "Where Did You Here About Us?".tr,
                ),
                10.0.height,
                CommonDropdownWidget(
                    selectedValue: controller.sourceSelected,
                    dropdownList: controller.sourceList,
                    title: "Where Did You Here About Us?".tr,
                    onChanged: (_) => controller.sourceSelected(_),
                    displayItem: 'name'),
                20.0.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Obx(() {
                        return Checkbox(
                          value: controller.checkBoxAgree.value,
                          side: BorderSide(width: 0.8, color: Colors.black54),
                          onChanged: (_) {
                            controller.checkBoxAgree.value = _ ?? false;
                          },
                          activeColor: ColorConstant.primaryColor,
                        );
                      }),
                    ),
                    5.0.width,
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'By proceeding, I agree that Carpedia collects my private data in accordance with the'
                                          .tr +
                                      " ",
                              style: context.textTheme.headline6!
                                  .copyWith(color: Colors.grey),
                            ),
                            TextSpan(
                              text: 'Privacy Notice'.tr,
                              style: context.textTheme.headline6!
                                  .copyWith(color: ColorConstant.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Implement the action to open the Privacy Notice here.
                                  print('Privacy Notice tapped');
                                },
                            ),
                            TextSpan(
                              text:
                                  ' ' + "and I fully comply with the".tr + ' ',
                              style: context.textTheme.headline6!
                                  .copyWith(color: Colors.grey),
                            ),
                            TextSpan(
                              text: 'Terms and Conditions'.tr,
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
                      ),
                    ),
                  ],
                ),
                20.0.height,
                Obx(() {
                  return controller.isLoading.isTrue
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CommonButton(
                          title: "Register".tr,
                          callBack: () {
                            if (controller.formKey.currentState!.validate()) {
                              if (controller.checkBoxAgree.isTrue) {
                                controller.register();
                              } else {
                                toastFailed(
                                    context: context,
                                    content:
                                        "Please agree to Privacy Notice and Terms & Conditions"
                                            .tr);
                              }
                            }
                          });
                }),
                60.0.height,
              ],
            ).paddingSymmetric(horizontal: width * 0.04),
          ),
        ),
      ),
    );
  }
}
