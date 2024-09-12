import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/register_checklist_header_widget.dart';
import 'package:hero/app/core/widgets/shimmer/shimmerlistview.dart';
import 'package:hero/app/core/widgets/text_field.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/modules/register_checklist/controllers/checklist_license_info_controller.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_add_license_view.dart';

import '../../../../core/widgets/common_dropdown_widget.dart';
import '../../../../data/constants/color_constant.dart';

class ChecklistLicenseInfoView extends GetView<ChecklistLicenseInfoController> {
  const ChecklistLicenseInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Driving License".tr),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.0.height,
            RegisterChecklistHeaderWidget(
                icon: FontAwesomeIcons.idCardClip,
                title: "Driving License".tr,
                subtitle:
                    "We need your Driving License info. You can add more than one license.".tr),
            30.0.height,
            Obx(() {
              return controller.isLoading.isTrue
                  ? const Expanded(child: ShimmerListView())
                  : Column(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                (controller
                                                .licenseInfoStatus
                                                .value
                                                .drivingLicense
                                                ?.licenseClasses ??
                                            [])
                                        .isEmpty
                                    ? const Icon(
                                        FontAwesomeIcons.plus,
                                        size: 15,
                                        color: Colors.grey,
                                      )
                                    : const Icon(
                                        FontAwesomeIcons.check,
                                        size: 15,
                                      ),
                                20.0.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Competent Driving License (CDL)".tr,
                                      style: context.textTheme.headline3!,
                                    ),
                                    5.0.height,
                                    Text(
                                      "${'Type'.tr}: ${controller.joinModelList(controller.licenseInfoStatus.value.drivingLicense?.licenseClasses ?? [])}",
                                      style: context.textTheme.headline6!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(
                                  FontAwesomeIcons.chevronRight,
                                  color: Colors.grey,
                                  size: 14,
                                )
                              ],
                            ).paddingSymmetric(vertical: 10),
                            Divider(
                              color: Colors.grey[300],
                              thickness: 0.5,
                            )
                          ],
                        ).onTap(() async {
                          await Get.to(ChecklistAddLicenseView(
                            isVDL: false,
                            item: controller
                                .licenseInfoStatus.value.drivingLicense,
                          ));
                          controller.clearAllField();
                        }),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                (controller
                                                .licenseInfoStatus
                                                .value
                                                .vocationalLicense
                                                ?.licenseClasses ??
                                            [])
                                        .isEmpty
                                    ? const Icon(
                                        FontAwesomeIcons.plus,
                                        size: 15,
                                        color: Colors.grey,
                                      )
                                    : const Icon(
                                        FontAwesomeIcons.check,
                                        size: 15,
                                      ),
                                20.0.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Vocational Driving License (VDL)".tr,
                                      style: context.textTheme.headline3!,
                                    ),
                                    5.0.height,
                                    Text(
                                      "${'Type'.tr}: ${controller.joinModelList(controller.licenseInfoStatus.value.vocationalLicense?.licenseClasses ?? [])}",
                                      style: context.textTheme.headline6!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Icon(
                                  FontAwesomeIcons.chevronRight,
                                  color: Colors.grey,
                                  size: 14,
                                )
                              ],
                            ).paddingSymmetric(vertical: 10),
                            Divider(
                              color: Colors.grey[300],
                              thickness: 0.5,
                            )
                          ],
                        ).onTap(() async {
                          await Get.to(
                            ChecklistAddLicenseView(
                              isVDL: true,
                              item: controller.licenseInfoStatus.value.vocationalLicense,
                            ),
                          );
                          controller.clearAllField();
                        }),
                      ],
                    );
            }),
            10.0.height,
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
      // bottomNavigationBar: Container(
      //   width: width,
      //   padding: EdgeInsets.all(15),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(0.5),
      //         spreadRadius: 5,
      //         blurRadius: 7,
      //         offset: const Offset(0, 3),
      //       ),
      //     ],
      //   ),
      //   child: CommonButton(title: "Continue", callBack: () {}),
      // ),
    );
  }
}
