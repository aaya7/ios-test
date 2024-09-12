import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_dropdown_widget.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/work_preference/controllers/work_preference_controller.dart';

import '../../../core/widgets/comming_soon_widget.dart';

class ServicePreferenceView extends GetView<WorkPreferenceController> {
  const ServicePreferenceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Service Preference"),
      body: ComingSoonWidget(
        child: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Service Details",
                style: context.textTheme.headline5!.copyWith(fontSize: 17),
              ),
              20.0.height,
              Text(
                "Choose Service",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonDropdownWidget(
                  selectedValue: controller.serviceSelected,
                  dropdownList: controller.serviceList,
                  title: "Service",
                  onChanged: (_) {
                    controller.serviceSelected.value = _;
                  },
                  displayItem: ""),
              20.0.height,
              Text(
                "Working Time",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonDropdownWidget(
                  selectedValue: controller.workingTimeSelected,
                  dropdownList: controller.workingTimeList,
                  title: "Working Time",
                  onChanged: (_) {
                    controller.workingTimeSelected.value = _;
                  },
                  displayItem: ""),
              20.0.height,
              Text(
                "Work Day Preferences",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonDropdownWidget(
                  selectedValue: controller.workDayPrefSelected,
                  dropdownList: controller.workDayPrefList,
                  title: "Work Day Preferences",
                  onChanged: (_) {
                    controller.workDayPrefSelected.value = _;
                  },
                  displayItem: ""),
              20.0.height,
              Text(
                "Phone Type",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonDropdownWidget(
                  selectedValue: controller.phoneTypeSelected,
                  dropdownList: controller.phoneTypeList,
                  title: "Phone Type",
                  onChanged: (_) {
                    controller.phoneTypeSelected.value = _;
                  },
                  displayItem: ""),
              20.0.height,
            ],
          ).paddingSymmetric(horizontal: width * 0.04, vertical: 10),
        ),
      ),
    );
  }
}
