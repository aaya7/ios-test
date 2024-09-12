import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/custom_bottom_sheet.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/main/controllers/main_controller.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_vehicle_info_view.dart';
import 'package:hero/app/modules/work_preference/views/service_preference_view.dart';
import 'package:hero/app/modules/work_preference/views/transport_detail_view.dart';
import 'package:lottie/lottie.dart';

import '../../../core/widgets/common_dropdown_widget.dart';
import '../../personal_info/views/personal_info_view.dart';
import '../controllers/work_preference_controller.dart';

class WorkPreferenceView extends GetView<WorkPreferenceController> {
  const WorkPreferenceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Work Preferences".tr),
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
                    FontAwesomeIcons.briefcase,
                    color: Colors.black54,
                    size: 18,
                  ),
                ),
                20.0.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Work Preferences".tr,
                      style:
                          context.textTheme.headline3!.copyWith(fontSize: 20),
                    ),
                    Text(
                      "View or edit your work preferences.".tr,
                      style:
                          context.textTheme.headline6!.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            30.0.height,
            ProfileContentMenuCard(
              title: "Service Preferences".tr,
              onTap: () => Get.to(
                () => ServicePreferenceView(),
              ),
            ),

            ProfileContentMenuCard(
                title: "Preferred Working Location".tr,
                onTap: () {
                  Get.find<MainController>().openUpdateLocationBottomSheet();
                }),
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}
