import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_dropdown_widget.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/personal_info/views/personal_info_view.dart';
import 'package:hero/app/modules/work_preference/controllers/work_preference_controller.dart';
import 'package:hero/app/modules/work_preference/views/vehicle_license_info_view.dart';

class TransportDetailView extends GetView<WorkPreferenceController> {
  const TransportDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Transport Details"),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.0.height,
            Text(
              "Transport Details",
              style: context.textTheme.headline5!.copyWith(fontSize: 17),
            ),
            20.0.height,
            Text(
              "Type of Vehicle Used",
              style:
                  context.textTheme.headline6!.copyWith(color: Colors.black54),
            ),
            5.0.height,
            CommonDropdownWidget(
                selectedValue: controller.vehicleSelected,
                dropdownList: controller.vehicleList,
                title: "Vehicle Used",
                onChanged: (_) {
                  controller.vehicleSelected.value = _;
                },
                displayItem: ""),
            20.0.height,
            Text(
              "Driving License(s)",
              style:
                  context.textTheme.headline6!.copyWith(color: Colors.black54),
            ),
            5.0.height,
            CommonDropdownWidget(
                selectedValue: controller.licenseTypeSelected,
                dropdownList: controller.licenseTypeList,
                title: "Driving License(s)",
                onChanged: (_) {
                  controller.licenseTypeSelected.value = _;
                },
                displayItem: ""),
            5.0.height,
            Text(
              "*You can select more than one",
              style: context.textTheme.headline3!
                  .copyWith(color: Colors.black54, fontSize: 12),
            ),
            20.0.height,
            Text(
              "Vehicle & License",
              style: context.textTheme.headline5!.copyWith(fontSize: 17),
            ),
            10.0.height,
            ProfileContentMenuCard(
              title: "View Vehilce Details",
              onTap: () => Get.to(() => VehicleLicenseInfoView()),
            ),
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}
