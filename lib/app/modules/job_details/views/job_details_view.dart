import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_textfield.dart';
import 'package:hero/app/core/widgets/custom_bottom_sheet.dart';
import 'package:hero/app/core/widgets/info_dialog.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/text_style_extensions.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/routes/app_pages.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import '../controllers/job_details_controller.dart';

class JobDetailsView extends GetView<JobDetailsController> {
  const JobDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Job Details".tr),
      body: Obx(() {
        return controller.isLoading.isTrue
            ? Center(
                child: LottieBuilder.asset(
                  "assets/lottie/van_loading.json",
                  width: 150,
                ),
              )
            : SizedBox(
                width: width,
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.fetchJobDetail();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CircleAvatar(
                                foregroundImage: CachedNetworkImageProvider(
                                    controller.jobModel.value.merchantLogoUrl ??
                                        '',
                                    headers: imageNetworkHeader),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.jobModel.value.merchantName} ${(controller.jobModel.value.locationName ?? '').capitalizeFirst}",
                                    style: context.textTheme.headline2!
                                        .copyWith(fontSize: 26),
                                  ),
                                  5.0.height,
                                  Text(
                                    (controller.jobModel.value.isFullTime ??
                                                0) ==
                                            1
                                        ? "Full-time".tr.toUpperCase()
                                        : "Part-time".tr.toUpperCase(),
                                    style: secondaryTextStyle(size: 12),
                                  ),
                                  5.0.height,
                                  Text(
                                    "${(controller.jobModel.value.productCategory ?? '').toUpperCase()} • ${controller.jobModel.value.productRoleName ?? ''}",
                                    style: secondaryTextStyle(
                                        size: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        20.0.height,
                        Row(
                          children: [
                            Expanded(
                              child: TitleDescriptionWidget(
                                title: 'Wage Detail'.tr.toUpperCase(),
                                subtitle: "RM ${(controller.jobModel.value
                                    .wageAmount ?? 0.0).toStringAsFixed(2)}/${controller.jobModel.value.wageUnit}",
                              ),
                            ),
                            Expanded(
                              child: TitleDescriptionWidget(
                                title: 'HUB'.tr,
                                subtitle:
                                    (controller.jobModel.value.locationName ??
                                                '')
                                            .capitalizeFirst ??
                                        '',
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: width * 0.04),
                        20.0.height,
                        Row(
                          children: [
                            Expanded(
                              child: TitleDescriptionWidget(
                                title: 'Availability'.tr.toUpperCase(),
                                subtitle:
                                    "${controller.jobModel.value.availableSlots ?? 0} slots",
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: width * 0.04),
                        10.0.height,
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.4,
                        ).paddingSymmetric(horizontal: 15),
                        10.0.height,
                        SizedBox(
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Job Description".tr,
                                style: context.textTheme.headline3!
                                    .copyWith(fontSize: 17),
                              ),
                              10.0.height,
                              Text(
                                controller.jobModel.value.jobDescription ?? "-",
                                style: context.textTheme.headline6!.copyWith(
                                    fontSize: 15, color: Colors.black54),
                              ),
                              10.0.height,
                              Text(
                                "Requirement".tr,
                                style: context.textTheme.headline3!
                                    .copyWith(fontSize: 17),
                              ),
                              10.0.height,
                              ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: controller.jobModel.value
                                          .requirementsString?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    final item = controller
                                        .jobModel.value.requirementsString
                                        ?.elementAt(index);
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: ColorConstant.primaryColor,
                                              width: 0.2)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item ?? '',
                                              style: context
                                                  .textTheme.headline6!
                                                  .copyWith(
                                                      color: Colors.black54,
                                                      fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ).marginOnly(bottom: 5),
                                    );
                                  }),
                            ],
                          ).paddingSymmetric(horizontal: width * 0.04),
                        ),
                        20.0.height,
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.4,
                        ).paddingSymmetric(horizontal: 15),
                      ],
                    ),
                  ),
                ),
              );
      }),
      bottomNavigationBar: Obx(() {
        return controller.isApplyLoading.isTrue
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: ColorConstant.primaryColor,
                  ),
                ],
              )
            : (controller.jobModel.value.canApply ?? false)
                ? CommonButton(
                    title: "Apply for this Job".tr,
                    callBack: () async {
                      Get.dialog(
                        InfoDialog(
                          title: "Apply Job".tr,
                          info:
                              "${"Are you sure want to apply".tr} ${(controller.jobModel.value.isFullTime ?? 0) == 1 ? "Full-time".tr : "Part time".tr}: ${controller.jobModel.value.merchantName} ${(controller.jobModel.value.locationName ?? '').capitalizeFirst}?\n\n${"Please enter date when you can report duty.".tr}",
                          confirmText: "Apply".tr.toUpperCase(),
                          // icon: Center(
                          //   child: LottieBuilder.asset(
                          //     "assets/lottie/apply.json",
                          //     height: 100,
                          //   ),
                          // ),
                          additionalWidget: Form(
                            key: controller.formKey,
                            child: CommonTextField(
                                    hintText: "Estimated start date".tr,
                                    enabled: false,
                                    textEditingController:
                                        controller.startDateTextController,
                                    title: "Estimated start date".tr)
                                .onTap(() {
                              controller.pickDate();
                            }),
                          )
                              .marginSymmetric(horizontal: 30)
                              .marginOnly(bottom: 30),
                          cancelText: "Cancel".tr.toUpperCase(),
                          confirmCallback: () async {
                            if (controller.formKey.currentState?.validate() ??
                                false) {
                              dismissDialog();
                              await controller.applyJob();
                            }
                          },
                        ),
                      );
                      //
                    })
                : CommonButton(
                    title: 'Apply for this Job'.tr,
                    buttonColor: Colors.grey,
                    callBack: () {
                      openBottomSheet(children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/lottie/sad.json",
                                width: width * 0.6, fit:  BoxFit.fitWidth),
                          ],
                        ),
                        ListView.builder(
                          itemCount: controller.jobModel.value.requirementsString?.length ?? 0,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            return Text(
                              "- ${controller.jobModel.value.requirementsString?.elementAt(index) ?? ''}\n",
                              // textAlign: TextAlign.center,
                              style: context.textTheme.headline6!
                                  .copyWith(color: Colors.black54, fontSize: 16),
                            ).paddingSymmetric(horizontal: 10);
                          }
                        ),
                        50.0.height,
                      ], title: 'Unable to Apply this Job'.tr);
                    });
      }).paddingSymmetric(horizontal: 15, vertical: 10),
    );
  }
}

class TitleDescriptionWidget extends StatelessWidget {
  const TitleDescriptionWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
  });

  final String title;
  final String subtitle;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.headline3!
              .copyWith(color: Colors.grey, fontSize: 13),
        ),
        Text(
          subtitle,
          style: context.textTheme.headline3!
              .copyWith(fontSize: 18, color: subtitleColor),
        )
      ],
    );
  }
}
