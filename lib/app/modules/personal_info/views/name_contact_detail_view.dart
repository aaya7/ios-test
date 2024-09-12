import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/personal_info/controllers/personal_info_controller.dart';

import '../../../core/widgets/common_dropdown_widget.dart';

class NameContactDetailView extends GetView<PersonalInfoController> {

  const NameContactDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Name & Contact Details"),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Details",
              style: context.textTheme.headline3!.copyWith(fontSize: 17),
            ),
            20.0.height,
            Text(
              "Name",
              style:
                  context.textTheme.headline6!.copyWith(color: Colors.black54),
            ),
            5.0.height,
            CommonTextField(hintText: "Enter name", title: "Name"),
            20.0.height,
            Text(
              "Email",
              style:
                  context.textTheme.headline6!.copyWith(color: Colors.black54),
            ),
            5.0.height,
            CommonTextField(hintText: "Enter email", title: "Email"),
            20.0.height,
            Text(
              "Mobile Number",
              style:
                  context.textTheme.headline6!.copyWith(color: Colors.black54),
            ),
            5.0.height,
            CommonTextField(
              hintText: "",
              title: "Mobile Number",
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
            Text("Preferred Location"),
            10.0.height,
            Row(
              children: [
                Expanded(
                  child: CommonDropdownWidget(
                      selectedValue: controller.stateSelected,
                      dropdownList: controller.stateList,
                      title: "State",
                      hintText: "State",
                      onChanged: (_) {
                        controller.stateSelected.value = _;
                      },
                      displayItem: ""),
                ),
                10.0.width,
                Expanded(
                  child: CommonDropdownWidget(
                      selectedValue: controller.citySelected,
                      dropdownList: controller.cityList,
                      title: "City",
                      hintText: "City",
                      onChanged: (_) {
                        controller.citySelected.value = _;
                      },
                      displayItem: ""),
                ),
              ],
            ),
            20.0.height,
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}
