import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_dropdown_widget.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/work_preference/controllers/work_preference_controller.dart';

import '../../../core/widgets/common_button.dart';
import '../../../data/constants/color_constant.dart';

class VehicleLicenseInfoView extends GetView<WorkPreferenceController> {
  const VehicleLicenseInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Vehicle Info"),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Vehicle Image",
                    style: context.textTheme.headline3!.copyWith(fontSize: 17),
                  ),
                  Text(
                    " (Required)*",
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.orange, fontSize: 17),
                  ),
                ],
              ),
              5.0.height,
              const Text("Photo of your vehicle must be clearly visible"),
              20.0.height,
              SizedBox(
                width: width,
                child: Column(
                  children: [
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
                        title: "Update",
                        callBack: () {},
                        border: Colors.grey[400],
                        buttonTextColor: ColorConstant.primaryColor,
                        buttonColor: Colors.white,
                        iconData: FontAwesomeIcons.camera,
                      ),
                    ),
                  ],
                ),
              ),
              20.0.height,
              const Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              20.0.height,
              Row(
                children: [
                  Text(
                    "Road Tax",
                    style: context.textTheme.headline3!.copyWith(fontSize: 17),
                  ),
                  Text(
                    " (Required)*",
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.orange, fontSize: 17),
                  ),
                ],
              ),
              5.0.height,
              const Text(
                  "Photo of the Road Tax must be clearly visible. Scanned or photocopied image is not accepted."),
              20.0.height,
              SizedBox(
                width: width,
                child: Column(
                  children: [
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
                        title: "Update",
                        callBack: () {},
                        border: Colors.grey[400],
                        buttonTextColor: ColorConstant.primaryColor,
                        buttonColor: Colors.white,
                        iconData: FontAwesomeIcons.camera,
                      ),
                    ),
                  ],
                ),
              ),
              20.0.height,
              const Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              20.0.height,
              Row(
                children: [
                  Text(
                    "GDL License Front",
                    style: context.textTheme.headline3!.copyWith(fontSize: 17),
                  ),
                  Text(
                    " (Required)*",
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.orange, fontSize: 17),
                  ),
                ],
              ),
              5.0.height,
              const Text(
                  "Photo of your GDL License must be clearly visible. Scanned or photocopied image is not accepted."),
              20.0.height,
              SizedBox(
                width: width,
                child: Column(
                  children: [
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
                        title: "Update",
                        callBack: () {},
                        border: Colors.grey[400],
                        buttonTextColor: ColorConstant.primaryColor,
                        buttonColor: Colors.white,
                        iconData: FontAwesomeIcons.camera,
                      ),
                    ),
                  ],
                ),
              ),
              20.0.height,
              const Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              // 20.0.height,
              // Row(
              //   children: [
              //     Text(
              //       "GDL License Back",
              //       style: context.textTheme.headline3!.copyWith(fontSize: 17),
              //     ),
              //     Text(
              //       " (Required)*",
              //       style: context.textTheme.headline6!
              //           .copyWith(color: Colors.orange, fontSize: 17),
              //     ),
              //   ],
              // ),
              // 5.0.height,
              // const Text(
              //     "Photo of your GDL License must be clearly visible. Scanned or photocopied image is not accepted."),
              // 20.0.height,
              // SizedBox(
              //   width: width,
              //   child: Column(
              //     children: [
              //       Container(
              //         width: Get.width * 0.45,
              //         height: 120,
              //         decoration: BoxDecoration(
              //             color: Colors.grey[300],
              //             borderRadius: BorderRadius.circular(10)),
              //         child: const Center(
              //           child: Icon(
              //             FontAwesomeIcons.image,
              //             color: Colors.grey,
              //             size: 40,
              //           ),
              //         ),
              //       ),
              //       10.0.height,
              //       SizedBox(
              //         width: width * 0.4,
              //         child: CommonButton(
              //           title: "Update",
              //           callBack: () {},
              //           border: Colors.grey[400],
              //           buttonTextColor: ColorConstant.primaryColor,
              //           buttonColor: Colors.white,
              //           iconData: FontAwesomeIcons.camera,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              20.0.height,
              const Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              20.0.height,
              Text(
                "Vehicle Type",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonDropdownWidget(
                  selectedValue: controller.vehicleTypeSelected,
                  dropdownList: controller.vehicleType,
                  title: "Vehicle Type",
                  onChanged: (_) {
                    controller.vehicleTypeSelected.value = _;
                  },
                  displayItem: ""),
              20.0.height,
              Text(
                "Vehicle Model",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonDropdownWidget(
                  selectedValue: controller.vehicleModelSelected,
                  dropdownList: controller.vehicleModelList,
                  title: "Vehicle Model",
                  onChanged: (_) {
                    controller.vehicleModelSelected.value = _;
                  },
                  displayItem: ""),
              20.0.height,
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Plate Number",
                        style: context.textTheme.headline6!
                            .copyWith(color: Colors.black54),
                      ),
                      5.0.height,
                      CommonTextField(
                          hintText: "Enter plate number", title: "Plate Number")
                    ],
                  )),
                  10.0.width,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Year",
                        style: context.textTheme.headline6!
                            .copyWith(color: Colors.black54),
                      ),
                      5.0.height,
                      CommonTextField(
                          hintText: "Enter year of vehicle", title: "Year")
                    ],
                  ))
                ],
              ),
              40.0.height,
            ],
          ).paddingSymmetric(horizontal: width * 0.04),
        ),
      ),
      bottomNavigationBar: CommonButton(title: "Save", callBack: () {})
          .paddingSymmetric(horizontal: width * 0.05, vertical: 15),
    );
  }
}
