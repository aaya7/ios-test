import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/core/widgets/info_dialog.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/account_management/views/view_payslip_view.dart';
import 'package:hero/app/modules/account_management/views/view_performance_view.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/services/local_db_services/local_db_services.dart';
import '../../../core/widgets/common_appbar.dart';
import '../../../routes/app_pages.dart';
import '../../personal_info/views/personal_info_view.dart';
import '../controllers/account_management_controller.dart';

class AccountManagementView extends GetView<AccountManagementController> {
  const AccountManagementView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Account Management"),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.0.height,
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[400]!)),
                  child: Icon(
                    FontAwesomeIcons.gear,
                    color: Colors.black54,
                    size: 18,
                  ),
                ),
                20.0.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account Management".tr,
                      style:
                          context.textTheme.headline3!.copyWith(fontSize: 20),
                    ),
                    Text(
                      "View payslips and manage your account.".tr,
                      style:
                          context.textTheme.headline6!.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            30.0.height,
            Text(
              "Payslip & Performance".tr,
              style: context.textTheme.headline3!.copyWith(fontSize: 17),
            ),
            20.0.height,
            ProfileContentMenuCard(
              title: "View Payslips".tr,
              onTap: () => Get.to(
                () => ViewPayslipView(),
              ),
            ),
            ProfileContentMenuCard(
              title: "View Performance".tr,
              onTap: () => Get.to(() => ViewPerformanceView()),
            ),
            30.0.height,
            Text(
              "Account".tr,
              style: context.textTheme.headline3!.copyWith(fontSize: 17),
            ),
            20.0.height,
            ProfileContentMenuCard(
              title: "Pause Account".tr,
              onTap: () {
                toastLong("Will be available soon".tr);
              },
            ),
            ProfileContentMenuCard(
              title: "Delete my Account".tr,
              onTap: () {
                Get.dialog(InfoDialog(
                  title: "Delete Account".tr,
                  info: "Are you sure want to permanently delete your account?".tr,
                  confirmText: "Delete".tr,
                  icon: const Icon(LineIcons.trash, size: 90, color: Colors.red,),
                  cancelText: "Cancel".tr,
                  confirmCallback: () {
                    dismissDialog();
                    LocalDBService.instance.clearDB();
                    Get.offAllNamed(Routes.SPLASH);
                  },
                  confirmButtonColor: Colors.red,
                ));
              },
            ),
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}
