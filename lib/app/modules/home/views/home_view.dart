import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/data/models/auth_models/registration_checklist_status_model.dart';
import 'package:hero/app/modules/jobs/controllers/jobs_controller.dart';
import 'package:hero/app/modules/main/controllers/main_controller.dart';
import 'package:hero/app/routes/app_pages.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/shimmer/shimmer_home_job.dart';
import '../../../data/constants/constant.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: width,
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchDashboard();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (MediaQuery.of(context).padding.top + 10).height,
                HomeAppBar(width: width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return controller.isChecklistLoading.isTrue
                          ? const SizedBox.shrink()
                          : controller.checklistIncompleteCount.value == 0
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    20.0.height,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "You're almost there".tr,
                                              style: context
                                                  .textTheme.headline3!
                                                  .copyWith(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                            ),
                                            Obx(() {
                                              return Text(
                                                "${controller.checklistIncompleteCount.value} ${"Steps Remaining".tr}",
                                                style: context
                                                    .textTheme.headline3!
                                                    .copyWith(
                                                        color: Colors.black54,
                                                        fontSize: 12),
                                              );
                                            })
                                          ],
                                        ),
                                        10.0.height,
                                        Text(
                                          "Finish Driver Setup".tr,
                                          style: context.textTheme.headline3!
                                              .copyWith(fontSize: 17),
                                        ),
                                        10.0.height,
                                        ListView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            padding: EdgeInsets.zero,
                                            itemCount: controller
                                                    .checklistStatusModel
                                                    .value
                                                    .checklistStatuses
                                                    ?.length ??
                                                0,
                                            itemBuilder: (_, index) {
                                              final item = controller
                                                  .checklistStatusModel
                                                  .value
                                                  .checklistStatuses
                                                  ?.elementAt(index);

                                              return Container(
                                                padding: EdgeInsets.all(10),
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: ColorConstant
                                                            .primaryColor,
                                                        width: 0.2)),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .warning_amber_rounded,
                                                      size: 15,
                                                      color: Colors.red,
                                                    ),
                                                    10.0.width,
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          (item?.name ?? '').replaceAll('Info', 'Information').tr,
                                                          style: context
                                                              .textTheme
                                                              .headline6!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    SizedBox(
                                                      height: 30,
                                                      child: CommonButton(
                                                          title: "Do Now".tr,
                                                          callBack: () {
                                                            controller
                                                                .routeToChecklist(item
                                                                        ?.type ??
                                                                    ChecklistType
                                                                        .license);
                                                          }),
                                                    ),
                                                  ],
                                                ).marginOnly(bottom: 5),
                                              );
                                            })
                                      ],
                                    ).commonContainer(width: width),
                                  ],
                                );
                    }),
                    20.0.height,
                    Text(
                      "Explore Job Near You".tr,
                      style:
                          context.textTheme.headline3!.copyWith(fontSize: 17),
                    ),
                    10.0.height,
                    Obx(() {
                      return controller.isLoading.isTrue
                          ? const ShimmerHomeJob()
                          : GridView.builder(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.only(top: 0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 11 / 9),
                              itemCount: controller.visibleItemCount <
                                      controller.jobNearbyList.length
                                  ? controller.visibleItemCount + 1
                                  : controller.jobNearbyList.length,
                              itemBuilder: (context, index) {
                                final item =
                                    controller.jobNearbyList.elementAt(index);

                                if (index == controller.visibleItemCount &&
                                    controller.visibleItemCount <
                                        controller.jobNearbyList.length) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[100]!,
                                          blurRadius: 5,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Text(
                                                "Browse All Jobs",
                                                style: context
                                                    .textTheme.headline3!
                                                    .copyWith(fontSize: 16),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 4,
                                              child: Row(
                                                children: [
                                                  const Spacer(),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.black54,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ).onTap(() {
                                    Get.find<MainController>()
                                        .contentIndex
                                        .value = 1;
                                    Get.find<JobsController>()
                                        .tabController
                                        .animateTo(0);
                                  });
                                }
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 0.1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[100]!,
                                        blurRadius: 5,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        right: 0,
                                        child: Image.asset(
                                          "assets/images/job_card.png",
                                          width: 30,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                (item.isFullTime ?? 0) == 0
                                                    ? "PART-TIME"
                                                    : "FULL-TIME",
                                                style: context
                                                    .textTheme.headline3!
                                                    .copyWith(
                                                        color: Colors.grey,
                                                        fontSize: 10),
                                              ),
                                              const Spacer(),
                                              CircleAvatar(
                                                radius: 15,
                                                foregroundImage:
                                                    CachedNetworkImageProvider(
                                                        item.merchantLogoUrl ??
                                                            '',
                                                        headers:
                                                            imageNetworkHeader),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Text(
                                            item.productCategory ?? '',
                                            style: context.textTheme.headline3!
                                                .copyWith(
                                                    fontSize: 16,
                                                    color: ColorConstant
                                                        .primaryColor),
                                          ),
                                          5.0.height,
                                          Text(
                                            "${item.merchantName ?? ''} ${(item.locationName ?? '')}",
                                            style: context.textTheme.headline3!
                                                .copyWith(
                                                    fontSize: 11,
                                                    color: ColorConstant.grey),
                                          ),
                                          5.0.height,
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_pin,
                                                color: Colors.black54,
                                                size: 14,
                                              ),
                                              3.0.width,
                                              Expanded(
                                                child: Text(
                                                  item.city ?? '',
                                                  style: context
                                                      .textTheme.headline6!
                                                      .copyWith(
                                                          fontSize: 11,
                                                          color: ColorConstant
                                                              .grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ).onTap(() => Get.toNamed(Routes.JOB_DETAILS,
                                    arguments: {"uuid": item.uuid}));
                              });
                    }),
                    20.0.height,
                    Obx(() {
                      return controller.assignedJobList.isEmpty
                          ? const SizedBox.shrink()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Assigned Job".tr,
                                  style: context.textTheme.headline3!
                                      .copyWith(fontSize: 17),
                                ),
                                Text(
                                  "View All".tr,
                                  style: context.textTheme.headline3!.copyWith(
                                      fontSize: 15,
                                      color: ColorConstant.primaryColor),
                                ).onTap(() {
                                  Get.find<MainController>()
                                      .contentIndex
                                      .value = 1;
                                  Get.find<JobsController>()
                                      .tabController
                                      .animateTo(1);
                                })
                              ],
                            );
                    }),
                    10.0.height,
                    Obx(() {
                      return controller.isAssignLoading.isTrue
                          ? SizedBox(
                              width: Get.width,
                              height: 200,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 0),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: controller.assignedJobList.length,
                              itemBuilder: (_, index) {
                                final item =
                                    controller.assignedJobList.elementAt(index);
                                return Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.only(bottom: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[100]!,
                                        blurRadius: 5,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: CircleAvatar(
                                          radius: 20,
                                          foregroundImage:
                                              CachedNetworkImageProvider(
                                                  item.merchantLogoUrl ?? '',
                                                  headers: imageNetworkHeader),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${item.merchantName ?? ''} ${item.locationName ?? ''}"
                                                  .toTitleCase(),
                                              style: context
                                                  .textTheme.headline3!
                                                  .copyWith(fontSize: 16),
                                            ),
                                            10.0.height,
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                          color: AssignmentStatusID
                                                              .getColor(
                                                                  item.assignmentStatusId ??
                                                                      0),
                                                          shape:
                                                              BoxShape.circle),
                                                    ),
                                                    5.0.width,
                                                    Text(
                                                      AssignmentStatusID.getTitle(
                                                              item.assignmentStatusId ??
                                                                  0)
                                                          .toUpperCase(),
                                                      style: context
                                                          .textTheme.headline3,
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  ' •  ${(item.isFullTime ?? 0) == 1 ? "FULL TIME" : "PART TIME"}',
                                                  style: context
                                                      .textTheme.headline3!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.black54),
                                                ),
                                              ],
                                            ),
                                            10.0.height,
                                            Row(
                                              children: [
                                                // Container(
                                                //   width: 10,
                                                //   height: 10,
                                                //   decoration: BoxDecoration(
                                                //       color: Colors.green,
                                                //       shape: BoxShape.circle),
                                                // ),
                                                // 5.0.width,
                                                Expanded(
                                                  child: Text(
                                                    "${item.productName ?? ''}  • ${item.productRoleName ?? ''}",
                                                    style: context
                                                        .textTheme.headline6!
                                                        .copyWith(
                                                            color: Colors.grey),
                                                  ),
                                                )
                                              ],
                                            ),
                                            10.0.height,
                                            Text(
                                              "RM ${(item.wageAmount ?? 0.0).toStringAsFixed(2)}/${item.wageUnit}",
                                            )
                                          ],
                                        ).paddingSymmetric(horizontal: 10),
                                      ),
                                      const Expanded(
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Icon(
                                              FontAwesomeIcons.chevronRight,
                                              color: Colors.black54,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ).onTap(() => Get.toNamed(
                                    Routes.ASSIGNED_JOB_DETAILS,
                                    arguments: {"uuid": item.uuid}));
                              });
                    }),
                  ],
                ).paddingSymmetric(horizontal: width * 0.04)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: 5),
      decoration: BoxDecoration(
        color: ColorConstant.primaryBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100]!,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Obx(() {
                return CircleAvatar(
                  radius: 23,
                  foregroundImage: CachedNetworkImageProvider(
                      // "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fHww&w=1000&q=80"
                      ((Get.find<MainController>())
                                  .profileModel
                                  .value
                                  .profilePhotoImageUrl !=
                              null)
                          ? (Get.find<MainController>()
                                  .profileModel
                                  .value
                                  .profilePhotoImageUrl ??
                              LocalDBService.instance.getAvatar())
                          : (Get.find<MainController>()
                                  .profileModel
                                  .value
                                  .profilePhotoUrl ??
                              LocalDBService.instance.getAvatar()),
                      // headers: {
                      //   "Authorization":
                      //       "Bearer ${LocalDBService.instance.getToken()}"
                      // },
                      headers: imageNetworkHeader),
                );
              }),
              Positioned(
                  right: 0,
                  width: 15,
                  height: 15,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                  ))
            ],
          ).onTap(() async {
            log("FCM Token: ${await FirebaseMessaging.instance.getToken()}");
          }),
          10.0.width,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Text(
                  Get.find<MainController>().profileModel.value.name ??
                      LocalDBService.instance.getUsername(),
                  style: context.textTheme.headline3,
                );
              }),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.locationArrow,
                    size: 12,
                  ),
                  5.0.width,
                  Obx(() {
                    var mainController = Get.find<MainController>();
                    return Text(
                      "${mainController.profileModel.value.preferredCityLocation ?? ''}, ${mainController.profileModel.value.preferredStateLocation ?? ''}",
                    );
                  }),
                  5.0.width,
                  Icon(
                    FontAwesomeIcons.chevronDown,
                    size: 12,
                  ),
                ],
              )
            ],
          ).onTap(() {
            Get.find<MainController>().openUpdateLocationBottomSheet();
          }),
        ],
      ),
    );
  }
}
