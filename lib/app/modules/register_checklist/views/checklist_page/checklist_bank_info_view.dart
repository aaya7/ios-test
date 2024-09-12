import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_image_placeholder.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/register_checklist_header_widget.dart';
import 'package:hero/app/core/widgets/text_field.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_bank_info_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_personal_info_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/register_checklist_controller.dart';

import '../../../../core/widgets/common_dropdown_widget.dart';
import '../../../../data/constants/color_constant.dart';

class ChecklistBankInfoView extends GetView<ChecklistBankInfoController> {
  const ChecklistBankInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Bank Info"),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.0.height,
                 RegisterChecklistHeaderWidget(
                    icon: FontAwesomeIcons.bank,
                    title: "Bank Information".tr,
                    subtitle: "We need your bank information and bank statement".tr),
                30.0.height,
                Text(
                  "Bank Details".tr,
                  style: context.textTheme.headline3!.copyWith(fontSize: 17),
                ),
                20.0.height,
                Text("Bank Name".tr),
                5.0.height,
                CommonDropdownWidget(
                    selectedValue: controller.bankSelected,
                    dropdownList: controller.bankList,
                    title: "Bank Name".tr,
                    onChanged: (_) {
                      controller.bankSelected.value = _;
                    },
                    displayItem: "name"),
                20.0.height,
                Text("Bank Account Holder Name".tr),
                5.0.height,
                CommonTextField(
                    hintText: "Bank Account Holder Name".tr,
                    textEditingController:
                        controller.accountHolderNameTextController,
                    type: TextFieldType.NAME,
                    title: "Bank Account Holder Name".tr),
                20.0.height,
                Text("Bank Account No".tr),
                5.0.height,
                CommonTextField(
                    hintText: "Your bank account no".tr,
                    textEditingController:
                        controller.accountNumberTextController,
                    type: TextFieldType.PHONE,
                    title: "Bank Account No".tr),
                20.0.height,
                Row(
                  children: [
                    Text(
                      "Bank Statement".tr,
                      style:
                          context.textTheme.headline3!.copyWith(fontSize: 17),
                    ),
                    Text(
                      " (${"Required".tr})",
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.orange, fontSize: 14),
                    ),
                  ],
                ),
                5.0.height,
                Text("Attach your latest bank statement here.".tr),
                20.0.height,
                SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      Obx(() {
                        return CommonImagePlaceholder(
                          imageString:
                              controller.bankInfoModel.value.bankStatementUrl ??
                                  '',
                          imageFile: controller.bankStatementImage,
                          deleteCallback: (_)async{
                            if(controller.bankStatementImage.value != null){
                              return true;
                            }

                            return await controller.deleteBankStatement();
                          },
                        );
                      }),
                      10.0.height,
                      SizedBox(
                        width: width * 0.4,
                        child: CommonButton(
                          title: "Take Photo".tr,
                          callBack: () {
                            CommonService.pickImageC(image: (_) {
                              controller.bankStatementImage.value = _;
                            });
                          },
                          border: Colors.grey[400],
                          buttonTextColor: ColorConstant.primaryColor,
                          buttonColor: Colors.white,
                          iconData: FontAwesomeIcons.camera,
                        ),
                      ),
                      10.0.height,
                      SizedBox(
                        width: width * 0.4,
                        child: CommonButton(
                          title: "Upload".tr,
                          callBack: () {
                            CommonService.pickImage(image: (_) {
                              controller.bankStatementImage.value = _;
                            });
                          },
                          border: Colors.grey[400],
                          buttonTextColor: ColorConstant.primaryColor,
                          buttonColor: Colors.white,
                          iconData: FontAwesomeIcons.upload,
                        ),
                      ),
                    ],
                  ),
                ),
                20.0.height,
                20.0.height,
              ],
            ).paddingSymmetric(horizontal: width * 0.04),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: width,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CommonButton(title: "Save".tr, callBack: () {
          if(controller.formKey.currentState!.validate()){
            controller.submitBankInfo();
          }
        }),
      ),
    );
  }
}
