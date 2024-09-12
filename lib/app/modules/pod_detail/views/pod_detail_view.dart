import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/info_dialog.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import '../../../core/widgets/common_button.dart';
import '../../../data/constants/color_constant.dart';
import '../../../data/constants/extensions/text_style_extensions.dart';
import '../../job_details/views/job_details_view.dart';
import '../controllers/pod_detail_controller.dart';

class PodDetailView extends GetView<PodDetailController> {
  const PodDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "POD Detail".tr, action: [
        IconButton(
            onPressed: () {
              Get.dialog(
                InfoDialog(
                  title: "${"Delete".tr} ${controller.podModel.value.jobCode ?? ''}",
                  info:
                      "Are you sure want to delete this POD? All data for this POD will permanently deleted.".tr,
                  confirmText: "Delete".tr.toUpperCase(),
                  icon: LottieBuilder.asset(
                    "assets/lottie/delete.json",
                    height: 100,
                  ),
                  confirmButtonColor: Colors.redAccent,
                  confirmCallback: () {
                    dismissDialog();
                    controller.deletePOD();
                  },
                  cancelText: "Cancel".tr.toUpperCase(),
                ),
              );
            },
            icon: Icon(
              LineIcons.trash,
              color: Colors.redAccent,
            ))
      ]),
      body: Obx(() {
        return controller.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: width,
                child: SingleChildScrollView(
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
                                  controller.podModel.value.jobCode ?? '',
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
                      (controller.jobModel.value.isLM ?? false)
                          ? 20.0.height
                          : const SizedBox.shrink(),
                      (controller.jobModel.value.isLM ?? false)
                          ? Row(
                              children: [
                                Expanded(
                                  child: TitleDescriptionWidget(
                                    title: "PARCEL RECEIVED".tr,
                                    subtitle: (controller.podModel.value
                                                .parcelsReceivedCount ??
                                            0)
                                        .toString(),
                                  ),
                                ),
                                Expanded(
                                  child: TitleDescriptionWidget(
                                    title: 'PARCEL DELIVERED'.tr,
                                    subtitle: (controller.podModel.value
                                                .parcelsDeliveredCount ??
                                            0)
                                        .toString(),
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: width * 0.04)
                          : const SizedBox.shrink(),
                      20.0.height,
                      Row(
                        children: [
                          Expanded(
                            child: TitleDescriptionWidget(
                              title: 'STATUS',
                              subtitle:
                                  (controller.podModel.value.jobStatusName ??
                                          '')
                                      .toUpperCase(),
                              subtitleColor: PODStatusID.getColor(
                                  controller.podModel.value.jobStatusId ?? 0),
                            ),
                          ),
                          10.0.width,
                          Expanded(
                            child: TitleDescriptionWidget(
                              title: 'JOB DATE'.tr,
                              subtitle: controller.podModel.value.jobDate ?? '',
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: width * 0.04),
                      10.0.height,
                      Divider(
                        color: Colors.grey[300],
                        thickness: 0.6,
                      ).paddingSymmetric(horizontal: 15),
                      10.0.height,
                      SizedBox(
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "POD SLIP ATTACHMENT".tr,
                              style: context.textTheme.headline3!
                                  .copyWith(color: Colors.grey, fontSize: 13),
                            ),
                            (((controller.podModel.value.parcelsReceivedCount ??
                                            0) ==
                                        0) &&
                                    ((controller.podModel.value
                                                .parcelsDeliveredCount ??
                                            0) ==
                                        0))
                                ? Text(
                                    '-',
                                    style:
                                        context.textTheme.headline3!.copyWith(
                                      fontSize: 18,
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      20.0.height,
                                      Image.network(
                                        controller.podModel.value.podImageUrl ??
                                            '',
                                        fit: BoxFit.cover,
                                        width: width,
                                        height: 200,
                                        headers: imageNetworkHeader,
                                      ),
                                      20.0.height,
                                      CommonButton(
                                        title: "View this POD".tr,
                                        callBack: () {
                                          showImageViewer(
                                              context,
                                              CachedNetworkImageProvider(
                                                  controller.podModel.value
                                                          .podImageUrl ??
                                                      '',
                                                  headers: imageNetworkHeader),
                                              immersive: false,
                                              useSafeArea: true,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                        },
                                        iconData: Icons.visibility_outlined,
                                        border: Colors.grey[400],
                                        buttonTextColor:
                                            ColorConstant.primaryColor,
                                        buttonColor: Colors.grey[100],
                                      ),
                                    ],
                                  ),
                          ],
                        ).paddingSymmetric(horizontal: width * 0.04),
                      ),
                      20.0.height,
                    ],
                  ),
                ),
              );
      }),
      bottomNavigationBar: Obx(() {
        return (controller.podModel.value.canEdit ?? false)
            ? Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: 15),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ]),
                child: CommonButton(
                  title: "Edit this POD".tr,
                  callBack: () {
                    controller.submitPODBottomSheet();
                  },
                  iconData: LineIcons.editAlt,
                  // border: Colors.blue,
                  // buttonTextColor: Colors.blue,
                  // buttonColor: Colors.grey[100],
                ),
              )
            : const SizedBox.shrink();
      }),
    );
  }
}
