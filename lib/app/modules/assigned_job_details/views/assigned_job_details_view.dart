import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_dropdown_widget.dart';
import 'package:hero/app/core/widgets/common_image_placeholder.dart';
import 'package:hero/app/core/widgets/custom_bottom_sheet.dart';
import 'package:hero/app/core/widgets/info_dialog.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/routes/app_pages.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/local_db_services/local_db_services.dart';
import '../../../core/widgets/common_button.dart';
import '../../../data/constants/constant.dart';
import '../../../data/constants/extensions/text_style_extensions.dart';
import '../controllers/assigned_job_details_controller.dart';

class AssignedJobDetailsView extends GetView<AssignedJobDetailsController> {
  const AssignedJobDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Job Details".tr, action: [
        Obx(() {
          return (controller.jobModel.value.canQuit ?? 0) == 1
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      border: Border.all(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Icon(
                        LineIcons.times,
                        color: Colors.red,
                        size: 14,
                      ),
                      3.0.width,
                      Text(
                        'Quit'.tr,
                        style: context.textTheme.headline3!
                            .copyWith(color: Colors.red),
                      )
                    ],
                  ),
                ).onTap(() {
                  Get.dialog(
                    InfoDialog(
                      title: 'Quit Assignment'.tr,
                      info: 'Are you sure want to quit this assignment?'.tr,
                      confirmText: 'Quit Assignment'.tr.toUpperCase(),
                      confirmButtonColor: Colors.red,
                      confirmCallback: () {
                        dismissDialog();
                        controller.quitAssignment();
                      },
                      cancelText: 'Cancel'.tr,
                    ),
                  );
                })
              : const SizedBox.shrink();
        }).marginOnly(right: 10),
      ]),
      body: SafeArea(
        child: Obx(() {
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: CircleAvatar(
                                  foregroundImage: CachedNetworkImageProvider(
                                      controller
                                              .jobModel.value.merchantLogoUrl ??
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
                                  subtitle:
                                      "RM ${(controller.jobModel.value.wageAmount ?? 0.0).toStringAsFixed(2)}/${controller.jobModel.value.wageUnit}",
                                ),
                              ),
                            ],
                          ),
                          20.0.height,
                          Row(
                            children: [
                              Expanded(
                                child: TitleDescriptionWidget(
                                  title: 'Status'.tr.toUpperCase(),
                                  subtitle: AssignmentStatusID.getTitle(
                                          controller.jobModel.value
                                                  .assignmentStatusId ??
                                              0)
                                      .toUpperCase(),
                                  textColor: AssignmentStatusID.getColor(
                                      controller.jobModel.value
                                              .assignmentStatusId ??
                                          0),
                                ),
                              ),
                              // Expanded(
                              //   child: TitleDescriptionWidget(
                              //     title: 'SUBMITTED DATE',
                              //     subtitle: "28 Aug 2023",
                              //   ),
                              // ),
                            ],
                          ),
                          20.0.height,
                          Text(
                            (controller.jobModel.value.isLM ?? false)
                                ? "Proof of Delivery Slip".tr.toUpperCase()
                                : "Proof of Attendance".tr.toUpperCase(),
                            style: context.textTheme.headline3!
                                .copyWith(color: Colors.grey, fontSize: 13),
                          ),
                          (controller.jobModel.value.podLists?.length ?? 0) == 0
                              ? Text(
                                  "-",
                                  style: context.textTheme.headline6!
                                      .copyWith(color: Colors.grey),
                                )
                              : SizedBox(
                                  width: width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: ListView.builder(
                                    itemCount: controller
                                            .jobModel.value.podLists?.length ??
                                        0,
                                    itemBuilder: (_, index) {
                                      final item = controller
                                          .jobModel.value.podLists
                                          ?.elementAt(index);
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          10.0.height,
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    color: Colors.grey[300],
                                                    child: Image.network(
                                                      item?.podImageUrl ?? '',
                                                      fit: BoxFit.cover,
                                                      headers:
                                                          imageNetworkHeader,
                                                      errorBuilder:
                                                          (_, __, ___) {
                                                        return const Center(
                                                          child: Icon(
                                                            LineIcons.box,
                                                            color: Colors.white,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              10.0.width,
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${item?.jobCode ?? ''}",
                                                    style: context
                                                        .textTheme.headline3!,
                                                  ),
                                                  5.0.height,
                                                  Text(
                                                    item?.jobStatusName ?? '',
                                                    style: context
                                                        .textTheme.headline6!
                                                        .copyWith(),
                                                  ),
                                                  5.0.height,
                                                  Text(
                                                    "${"Job date on".tr} ${item?.jobDate ?? ''}",
                                                    style: context
                                                        .textTheme.headline6!
                                                        .copyWith(
                                                            color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              const Icon(
                                                FontAwesomeIcons.chevronRight,
                                                size: 15,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          5.0.height,
                                          Divider(
                                            thickness: 0.5,
                                            color: Colors.grey[300],
                                          )
                                        ],
                                      ).onTap(() {
                                        if (controller.jobModel.value.isLM ??
                                            false) {
                                          Get.toNamed(Routes.POD_DETAIL,
                                              arguments: {
                                                "uuid": item?.uuid,
                                                "job": controller.jobModel.value
                                              });
                                        }
                                      });
                                    },
                                  ),
                                ),
                          20.0.height,
                          Text(
                            "Information".tr,
                            style: context.textTheme.headline3!
                                .copyWith(fontSize: 17),
                          ),
                          10.0.height,
                          ListView.builder(
                              itemCount: controller
                                      .jobModel.value.informations?.length ??
                                  0,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (_, index) {
                                final item = controller
                                    .jobModel.value.informations
                                    ?.elementAt(index);
                                return (item?.value ?? '').isEmpty
                                    ? const SizedBox.shrink()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${item?.title ?? ''}",
                                            style: context.textTheme.headline3!
                                                .copyWith(
                                                    fontSize: 15,
                                                    color: ColorConstant
                                                        .primaryColor),
                                          ),
                                          5.0.height,
                                          UrlText(text: item?.value ?? '')
                                        ],
                                      ).marginOnly(bottom: 10);
                              }),
                          20.0.height,
                          Text(
                            "Requirement".tr,
                            style: context.textTheme.headline3!
                                .copyWith(fontSize: 17),
                          ),
                          10.0.height,
                          ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: controller
                                      .jobModel.value.requirements?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final item = controller
                                    .jobModel.value.requirements
                                    ?.elementAt(index);
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: ColorConstant.primaryColor,
                                          width: 0.2)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: (item?.checklistStatus ?? false)
                                            ? const Icon(
                                                LineIcons.check,
                                                size: 15,
                                              )
                                            : const Icon(
                                                LineIcons.times,
                                                size: 15,
                                                color: Colors.red,
                                              ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.getRequirementType(
                                                  item?.requirement ?? ''),
                                              style: context
                                                  .textTheme.headline3!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                            ),
                                            5.0.height,
                                            Text(
                                              item?.name ?? '',
                                              style: context
                                                  .textTheme.headline6!
                                                  .copyWith(
                                                      color: Colors.black54,
                                                      fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: (item?.requirement ==
                                                "onboarding_checklist")
                                            ? ((item?.checklistStatus ??
                                                        false) &&
                                                    (item?.hasVideo ?? false))
                                                ? (SizedBox(
                                                    height: 30,
                                                    child: CommonButton(
                                                        title: "View".tr,
                                                        callBack: () {
                                                          Get.toNamed(
                                                              Routes.ONBOARDING,
                                                              arguments: {
                                                                "assignment": controller
                                                                        .jobModel
                                                                        .value
                                                                        .uuid ??
                                                                    '',
                                                                "read_only":
                                                                    true
                                                              });
                                                        }),
                                                  ))
                                                : (!(item?.checklistStatus ??
                                                            false) &&
                                                        (item?.hasVideo ??
                                                            false))
                                                    ? SizedBox(
                                                        height: 30,
                                                        child: CommonButton(
                                                            title: "Do Now".tr,
                                                            callBack: () {
                                                              controller
                                                                  .routeToChecklist(
                                                                      item?.requirement ??
                                                                          '');
                                                            }),
                                                      )
                                                    : const SizedBox.shrink()
                                            : ((item?.checklistStatus ?? false)
                                                ? const SizedBox.shrink()
                                                : SizedBox(
                                                    height: 30,
                                                    child: CommonButton(
                                                        title: "Do Now".tr,
                                                        callBack: () {
                                                          controller
                                                              .routeToChecklist(
                                                                  item?.requirement ??
                                                                      '');
                                                        }),
                                                  )),
                                      ),
                                    ],
                                  ).marginOnly(bottom: 5),
                                );
                              }),
                        ],
                      ).paddingSymmetric(horizontal: width * 0.04),
                    ),
                  ),
                );
        }),
      ),
      bottomNavigationBar: Obx(() {
        return controller.isLoading.isTrue
            ? const SizedBox.shrink()
            // : true
            : (controller.jobModel.value.canSubmitPod ?? false)
                ? Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        15.0.height,
                        SizedBox(
                          height: 50,
                          child: CommonButton(
                            title: (controller.jobModel.value.isLM ?? false)
                                ? "Submit a POD".tr
                                : "Submit a POA".tr,
                            callBack: () {
                              if (controller.jobModel.value.isLM ?? false) {
                                controller.submitPODBottomSheet();
                              } else {
                                controller.submitPOABottomSheet();
                              }
                            },
                            iconData: FontAwesomeIcons.fileArrowUp,
                            border: Colors.grey[400],
                            buttonTextColor: ColorConstant.primaryColor,
                            buttonColor: Colors.grey[100],
                          ),
                        ),
                        10.0.height,
                        (controller.jobModel.value.isLM ?? false)
                            ? RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text:
                                        "You can use your camera to snap a photo of the POD, or upload it from your gallery."
                                            .tr,
                                    style: context.textTheme.headline6!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 14),
                                    children: [
                                      TextSpan(
                                        text: " ${"View Example Here".tr}",
                                        style: context.textTheme.headline3!
                                            .copyWith(
                                                color: Colors.blueAccent,
                                                fontSize: 14),
                                      )
                                    ]),
                              ).onTap(() {
                                showImageViewer(
                                    context,
                                    CachedNetworkImageProvider(
                                      controller
                                              .jobModel.value.examplePODImage ??
                                          '',
                                      headers: {
                                        "Authorization":
                                            "Bearer ${LocalDBService.instance.getToken()}"
                                      },
                                    ),
                                    immersive: false,
                                    useSafeArea: true,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true);
                              })
                            : const SizedBox.shrink()
                      ],
                    ).paddingSymmetric(horizontal: width * 0.04),
                  )
                : const SizedBox.shrink();
      }),
      // bottomNavigationBar:
      //     CommonButton(title: "Mark Job as Done", callBack: () {})
      //         .paddingSymmetric(horizontal: 15, vertical: 10),
    );
  }
}

class TitleDescriptionWidget extends StatelessWidget {
  const TitleDescriptionWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.textColor,
  });

  final String title;
  final String subtitle;
  final Color? textColor;

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
              .copyWith(fontSize: 18, color: textColor),
        )
      ],
    );
  }
}

class UrlText extends StatelessWidget {
  final String text;

  UrlText({required this.text});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(text);

    // Check if the text is a valid URL
    final isUrl = uri != null &&
        (uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'));

    return GestureDetector(
      onTap: isUrl ? () => _launchURL(uri.toString()) : null,
      child: Text(
        text,
        style: context.textTheme.headline6!.copyWith(
          color: isUrl ? Colors.blue : Colors.black54,
          fontSize: 15,
          decoration: isUrl ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
