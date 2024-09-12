import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_dropdown_widget.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/custom_bottom_sheet.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/personal_info/views/personal_info_view.dart';

import '../../../core/widgets/common_button.dart';
import '../../../data/constants/color_constant.dart';
import '../controllers/personal_info_controller.dart';

class BankInfoView extends GetView<PersonalInfoController> {
  const BankInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Banking Info"),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.0.height,
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
                    FontAwesomeIcons.bank,
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
                        "Banking Info",
                        style:
                            context.textTheme.headline3!.copyWith(fontSize: 20),
                      ),
                      Text(
                        "View or edit your banking info. This will be the account where you’ll receive your payouts.",
                        style:
                            context.textTheme.headline6!.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            30.0.height,
            Text(
              "Bank Name",
              style:
                  context.textTheme.headline6!.copyWith(color: Colors.black54),
            ),
            5.0.height,
            CommonDropdownWidget(
                selectedValue: controller.bankSelected,
                dropdownList: controller.bankList,
                title: "Bank Name",
                onChanged: (_) {
                  controller.bankSelected.value = _;
                },
                displayItem: ""),
            20.0.height,
            Text(
              "Bank Account No.",
              style:
                  context.textTheme.headline6!.copyWith(color: Colors.black54),
            ),
            5.0.height,
            CommonTextField(
                hintText: "Enter bank account number",
                title: "Bank Account No."),
            20.0.height,
            Text(
              "Bank Statement",
              style:
                  context.textTheme.headline6!.copyWith(color: Colors.black54),
            ),
            10.0.height,
            ProfileContentMenuCard(
              title: "View Uploaded Bank Statement",
              onTap: () => openBottomSheet(children: [
                SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      20.0.height,
                      Container(
                        width: Get.width * 0.45,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Icon(
                            FontAwesomeIcons.image,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),
                      10.0.height,
                      SizedBox(
                        width: width * 0.4,
                        child: CommonButton(
                          title: "Take Photo",
                          callBack: () {},
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
                          title: "Upload",
                          callBack: () {},
                          border: Colors.grey[400],
                          buttonTextColor: ColorConstant.primaryColor,
                          buttonColor: Colors.white,
                          iconData: FontAwesomeIcons.upload,
                        ),
                      ),
                      40.0.height,
                      CommonButton(title: "Save", callBack: (){})
                    ],
                  ),
                ),
              ], title: "View Bank Statement"),
            )
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}
