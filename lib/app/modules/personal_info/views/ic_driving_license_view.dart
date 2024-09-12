import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/personal_info/views/edit_ic_driving_license_view.dart';
import 'package:hero/app/modules/personal_info/views/personal_info_view.dart';

import '../controllers/personal_info_controller.dart';

class IcDrivingLicenseView extends GetView<PersonalInfoController> {
  const IcDrivingLicenseView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "NRIC & Driving License"),
      body: SizedBox(
        width: width,
        child: Column(
          children: [
            20.0.height,
            ProfileContentMenuCard(title: "NRIC", subtitle: "View NRIC info", onTap: ()=>Get.to(()=>EditIcDrivingLicenseView(true)),),
            ProfileContentMenuCard(title: "Driving License", subtitle: "View Driving License info",onTap: ()=>Get.to(()=>EditIcDrivingLicenseView(false))),
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}
