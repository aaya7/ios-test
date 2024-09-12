import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/common_dropdown_widget.dart';
import 'package:hero/app/core/widgets/common_no_data_error.dart';
import 'package:hero/app/core/widgets/common_tabbar_widget.dart';
import 'package:hero/app/core/widgets/shimmer/shimmerlistview.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/string_extensions.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/routes/app_pages.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../controllers/jobs_controller.dart';

class JobsView extends GetView<JobsController> {
  const JobsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (MediaQuery.of(context).padding.top).height,
            10.0.height,
            Text(
              "Jobs".tr,
              style: context.textTheme.headline2!,
            ).paddingSymmetric(horizontal: width * 0.04),
            20.0.height,
            CommonTabBarWidget(
                tabController: controller.tabController,
                tabBarList: [
                  Tab(
                    text: "Job Listing".tr,
                  ),
                  Tab(
                    text: "Assigned Job".tr,
                  ),
                ]).paddingSymmetric(horizontal: width * 0.04),
            10.0.height,
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: const [JobListingPage(), AssignedJobListingPage()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobListingPage extends GetView<JobsController> {
  const JobListingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          width: Get.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.filterChipList.length,
              padding: EdgeInsets.only(left: Get.width * 0.04),
              itemBuilder: (_, index) {
                final item = controller.filterChipList.elementAt(index);
                return Obx(() {
                  bool selected = controller.filterSelected.value == item;
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: selected
                                ? ColorConstant.primaryColor
                                : Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        item == "Filter"
                            ? const Icon(
                                LineIcons.filter,
                                size: 15,
                                color: ColorConstant.textPrimaryColor,
                              ).paddingOnly(right: 5)
                            : const SizedBox.shrink(),
                        Text(
                          item.tr,
                          style: context.textTheme.headline3!.copyWith(
                              color: selected
                                  ? ColorConstant.primaryColor
                                  : ColorConstant.textPrimaryColor),
                        ),
                      ],
                    ),
                  ).onTap(() async {
                    controller.filterSelected.value = item;
                    if (item == "Filter") {
                      await Get.bottomSheet(const BottomSheetFilterJob(),
                          isScrollControlled: true);

                      if (controller.isFiltered == false) {
                        controller.clearFilter();
                      }
                    }
                  }, borderRadius: BorderRadius.circular(20));
                });
              }),
        ),
        10.0.height,
        Expanded(
          child: Obx(() {
            return controller.isLoading.isTrue
                ? const ShimmerListView()
                : controller.jobList.isEmpty
                    ? const CommonNoDataErrorWidget()
                    : SmartRefresher(
                        controller: controller.refreshController,
                        footer: ClassicFooter(
                          textStyle: context.textTheme.titleLarge!
                              .copyWith(color: Colors.grey),
                          loadingText: 'Loading..',
                          loadStyle: LoadStyle.ShowWhenLoading,
                        ),
                        enablePullUp: true,
                        onRefresh: () async {
                          await controller.fetchJobs();
                          controller.refreshController.refreshCompleted();
                        },
                        onLoading: () async {
                          await controller.fetchNextPageJobs();
                          controller.refreshController.loadComplete();
                        },
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 0),
                            itemCount: controller.jobList.length,
                            itemBuilder: (_, index) {
                              final item = controller.jobList.elementAt(index);
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
                                            style: context.textTheme.headline3!
                                                .copyWith(fontSize: 16),
                                          ),
                                          10.0.height,
                                          Text(
                                            '${(item.isFullTime ?? 0) == 1 ? "Full-time".tr : "Part-time".tr}  •  ${(item.productCategory ?? '')}',
                                            style: context.textTheme.headline3!
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.black54),
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
                              ).onTap(() => Get.toNamed(Routes.JOB_DETAILS,
                                  arguments: {"uuid": item.uuid}));
                            }),
                      ).paddingSymmetric(horizontal: Get.width * 0.04);
          }),
        ),
      ],
    );
  }
}

class AssignedJobListingPage extends GetView<JobsController> {
  const AssignedJobListingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(
        //   height: 30,
        //   width: Get.width,
        //   child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       padding: EdgeInsets.only(left: Get.width * 0.04),
        //       itemCount: controller.assignedFilterChipList.length,
        //       itemBuilder: (_, index) {
        //         final item = controller.assignedFilterChipList.elementAt(index);
        //         return Obx(() {
        //           bool selected =
        //               controller.assignedFilterSelected.value == item;
        //           return Container(
        //             padding:
        //                 const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        //             margin: const EdgeInsets.only(right: 5),
        //             decoration: BoxDecoration(
        //                 color: Colors.white,
        //                 border: Border.all(
        //                     color: selected
        //                         ? ColorConstant.primaryColor
        //                         : Colors.grey[300]!),
        //                 borderRadius: BorderRadius.circular(20)),
        //             child: Text(
        //               item,
        //               style: context.textTheme.headline3!.copyWith(
        //                   color: selected
        //                       ? ColorConstant.primaryColor
        //                       : ColorConstant.textPrimaryColor),
        //             ),
        //           ).onTap(() {
        //             controller.assignedFilterSelected.value = item;
        //           }, borderRadius: BorderRadius.circular(20));
        //         });
        //       }),
        // ),
        10.0.height,
        Expanded(
          child: Obx(() {
            return controller.isAssignLoading.isTrue
                ? const ShimmerListView()
                    .paddingSymmetric(horizontal: Get.width * 0.04)
                : controller.assignedJobList.isEmpty
                    ? const NoJobDataWidget()
                    : SmartRefresher(
                        controller: controller.refreshController2,
                        footer: ClassicFooter(
                          textStyle: context.textTheme.titleLarge!
                              .copyWith(color: Colors.grey),
                          loadingText: 'Loading..',
                          loadStyle: LoadStyle.ShowWhenLoading,
                        ),
                        enablePullUp: false,
                        onRefresh: () async {
                          await controller.fetchAssignedJob();
                          controller.refreshController.refreshCompleted();
                        },
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 0),
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
                                            style: context.textTheme.headline3!
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
                                                        shape: BoxShape.circle),
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
                                                        color: Colors.black54),
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
                            }),
                      ).paddingSymmetric(horizontal: Get.width * 0.04);
          }),
        ),
      ],
    );
  }
}

class BottomSheetFilterJob extends GetView<JobsController> {
  const BottomSheetFilterJob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: Colors.white,
        height: Get.height * 0.8,
        width: Get.width,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Filter".tr,
                      style:
                          context.textTheme.headline3!.copyWith(fontSize: 20),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    controller.clearFilter();
                    dismissBottomSheet();
                  },
                  child: Text(
                    "Clear".tr,
                    style: context.textTheme.headline6!.copyWith(
                        color: ColorConstant.primaryColor, fontSize: 16),
                  ),
                )
              ],
            ),
            20.0.height,
            SizedBox(
              width: Get.width,
              height: Get.height * 0.6,
              child: Obx(() {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Sort",
                      //   style:
                      //   context.textTheme.headline3!.copyWith(fontSize: 17),
                      // ),
                      // RadioListTile(
                      //   contentPadding: EdgeInsets.zero,
                      //   activeColor: ColorConstant.primaryColor,
                      //   title: Text(
                      //     'Relevance (Default)',
                      //     style: context.textTheme.headline6!
                      //         .copyWith(color: Colors.black54, fontSize: 17),
                      //   ),
                      //   value: 'Relevance (Default)',
                      //   groupValue: controller.sortSelected.value,
                      //   onChanged: (value) {
                      //     controller.sortSelected.value = value ?? '';
                      //   },
                      //   controlAffinity: ListTileControlAffinity.trailing,
                      // ),
                      // RadioListTile(
                      //   contentPadding: EdgeInsets.zero,
                      //   activeColor: ColorConstant.primaryColor,
                      //   title: Text(
                      //     'Highest Pay',
                      //     style: context.textTheme.headline6!
                      //         .copyWith(color: Colors.black54, fontSize: 17),
                      //   ),
                      //   value: 'Highest Pay',
                      //   groupValue: controller.sortSelected.value,
                      //   onChanged: (value) {
                      //     controller.sortSelected.value = value ?? '';
                      //   },
                      //   controlAffinity: ListTileControlAffinity.trailing,
                      // ),
                      // RadioListTile(
                      //   contentPadding: EdgeInsets.zero,
                      //   activeColor: ColorConstant.primaryColor,
                      //   title: Text(
                      //     'Nearest',
                      //     style: context.textTheme.headline6!
                      //         .copyWith(color: Colors.black54, fontSize: 17),
                      //   ),
                      //   value: 'Nearest',
                      //   groupValue: controller.sortSelected.value,
                      //   onChanged: (value) {
                      //     controller.sortSelected.value = value ?? '';
                      //   },
                      //   controlAffinity: ListTileControlAffinity.trailing,
                      // ),
                      // Divider(
                      //   color: Colors.grey[300]!,
                      // ),
                      // 10.0.height,
                      Text(
                        "Job",
                        style:
                            context.textTheme.headline3!.copyWith(fontSize: 17),
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: ColorConstant.primaryColor,
                        title: Text(
                          'Full Time',
                          style: context.textTheme.headline6!
                              .copyWith(color: Colors.black54, fontSize: 17),
                        ),
                        value: controller.isSortFullTime.value,
                        visualDensity: VisualDensity.compact,
                        onChanged: (value) {
                          controller.isSortFullTime.value = value ?? false;
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: ColorConstant.primaryColor,
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          'Part Time',
                          style: context.textTheme.headline6!
                              .copyWith(color: Colors.black54, fontSize: 17),
                        ),
                        value: controller.isSortPartTime.value,
                        onChanged: (value) {
                          controller.isSortPartTime.value = value ?? false;
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      Divider(
                        color: Colors.grey[300]!,
                      ),
                      10.0.height,
                      Text(
                        "Available Location",
                        style:
                            context.textTheme.headline3!.copyWith(fontSize: 17),
                      ),
                      10.0.height,
                      Row(
                        children: [
                          Expanded(
                            child: CommonDropdownWidget(
                                    selectedValue:
                                        controller.availableStatesSelected,
                                    dropdownList: controller.availableStates,
                                    title: "States",
                                    onChanged: (_) {
                                      controller.availableStatesSelected(_);
                                      controller.availableCitiesSelected.value =
                                          null;
                                      controller.fetchAvailableLocationCities(
                                          state: _);
                                    },
                                    displayItem: "")
                                .paddingOnly(right: 10),
                          ),
                          Expanded(
                            child: CommonDropdownWidget(
                                selectedValue:
                                    controller.availableCitiesSelected,
                                dropdownList: controller.availableCities,
                                title: "Cities",
                                onChanged: (_) {
                                  controller.availableCitiesSelected(_);
                                },
                                displayItem: ""),
                          ),
                        ],
                      ),
                      10.0.height,
                      Divider(
                        color: Colors.grey[300]!,
                      ),
                      10.0.height,
                      // Text(
                      //   "Merchant",
                      //   style:
                      //       context.textTheme.headline3!.copyWith(fontSize: 17),
                      // ),
                      // 10.0.height,
                      // Obx(() {
                      //   return Wrap(
                      //     spacing: 8,
                      //     // Adjust the spacing between chips as needed
                      //     children: controller.filterMerchantList.map((label) {
                      //       final bool isSelected = controller
                      //           .filterMerchantListSelected
                      //           .contains(label);
                      //
                      //       return ChoiceChip(
                      //         label: Text(
                      //           label.name ?? '',
                      //           style: context.textTheme.headline6!.copyWith(
                      //               fontSize: 17,
                      //               color: isSelected
                      //                   ? ColorConstant.white
                      //                   : Colors.black54),
                      //         ),
                      //         side: BorderSide(
                      //             color: isSelected
                      //                 ? ColorConstant.primaryColor
                      //                 : Colors.grey[300]!),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(
                      //               20), // Adjust the radius as needed
                      //         ),
                      //         selectedColor: ColorConstant.primaryColor,
                      //         selected: isSelected,
                      //         onSelected: (isSelected) {
                      //           if (isSelected) {
                      //             controller.filterMerchantListSelected
                      //                 .add(label);
                      //           } else {
                      //             controller.filterMerchantListSelected
                      //                 .remove(label);
                      //           }
                      //         },
                      //       );
                      //     }).toList(),
                      //   );
                      // }),
                      // 10.0.height,
                      // Divider(
                      //   color: Colors.grey[300]!,
                      // ),
                      // 10.0.height,
                      Text(
                        'Full-time'.tr,
                        style: context.textTheme.headline3!
                            .copyWith(fontSize: 17, color: ColorConstant.primaryColor),
                      ),
                      20.0.height,
                      Obx(() {
                        return ListView.builder(
                            itemCount: controller
                                    .productRoleModel.value.fullTime?.length ??
                                0,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (_, index) {
                              var job = controller
                                  .productRoleModel.value.fullTime
                                  ?.elementAt(index);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    job?.name ?? '',
                                    style: context.textTheme.headline3!
                                        .copyWith(fontSize: 17),
                                  ),
                                  ListView.builder(
                                      itemCount: controller
                                              .productRoleModel.value.fullTime
                                              ?.elementAt(index)
                                              .productRoles
                                              ?.length ??
                                          0,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (_, index2) {
                                        var item = controller
                                            .productRoleModel.value.fullTime
                                            ?.elementAt(index)
                                            .productRoles
                                            ?.elementAt(index2);
                                        return Obx(() {
                                          return CheckboxListTile(
                                            contentPadding: const EdgeInsets.only(left: 20),
                                            activeColor:
                                                ColorConstant.primaryColor,
                                            title: Text(
                                              item?.name ?? '',
                                              style: context
                                                  .textTheme.headline6!
                                                  .copyWith(
                                                      color: Colors.black54,
                                                      fontSize: 17),
                                            ),
                                            value: controller
                                                .selectedProductRoleList
                                                .contains(item),
                                            visualDensity:
                                                VisualDensity.compact,
                                            onChanged: (value) {
                                              if (value == true) {
                                                controller.selectedProductRoleList.add(item!);
                                              } else {
                                                controller.selectedProductRoleList.remove(item!);
                                              }
                                            },
                                            // controlAffinity: ListTileControlAffinity
                                            //     .trailing,
                                          );
                                        });
                                      }),
                                  15.0.height,
                                ],
                              );
                            });
                      }),
                      // 10.0.height,
                      Divider(
                        color: Colors.grey[300]!,
                      ),
                      20.0.height,
                      Text(
                        'Part-time'.tr,
                        style: context.textTheme.headline3!
                            .copyWith(fontSize: 17, color: ColorConstant.primaryColor),
                      ),
                      20.0.height,
                      Obx(() {
                        return ListView.builder(
                            itemCount: controller
                                .productRoleModel.value.partTime?.length ??
                                0,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (_, index) {
                              var job = controller
                                  .productRoleModel.value.partTime
                                  ?.elementAt(index);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    job?.name ?? '',
                                    style: context.textTheme.headline3!
                                        .copyWith(fontSize: 17),
                                  ),
                                  ListView.builder(
                                      itemCount: controller
                                          .productRoleModel.value.partTime
                                          ?.elementAt(index)
                                          .productRoles
                                          ?.length ??
                                          0,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemBuilder: (_, index2) {
                                        var item = controller
                                            .productRoleModel.value.partTime
                                            ?.elementAt(index)
                                            .productRoles
                                            ?.elementAt(index2);
                                        return Obx(() {
                                          return CheckboxListTile(
                                            contentPadding: const EdgeInsets.only(left: 20),
                                            activeColor:
                                            ColorConstant.primaryColor,
                                            title: Text(
                                              item?.name ?? '',
                                              style: context
                                                  .textTheme.headline6!
                                                  .copyWith(
                                                  color: Colors.black54,
                                                  fontSize: 17),
                                            ),
                                            value: controller.selectedProductRoleList.contains(item),
                                            visualDensity:
                                            VisualDensity.compact,
                                            onChanged: (value) {
                                              if (value == true) {
                                                controller.selectedProductRoleList.add(item!);
                                              } else {
                                                controller.selectedProductRoleList.remove(item!);
                                              }
                                            },
                                            // controlAffinity: ListTileControlAffinity
                                            //     .trailing,
                                          );
                                        });
                                      }),
                                  15.0.height,
                                ],
                              );
                            });
                      }),
                      // 10.0.height,
                      Divider(
                        color: Colors.grey[300]!,
                      ),

                      30.0.height,
                    ],
                  ),
                );
              }),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 10),
              child: CommonButton(
                title: "Apply",
                callBack: () {
                  controller.isFiltered = true;
                  controller.fetchJobs();
                  dismissBottomSheet();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoJobDataWidget extends StatelessWidget {
  const NoJobDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: const Icon(
              FontAwesomeIcons.briefcase,
              color: Colors.grey,
              size: 40,
            ),
          ),
          20.0.height,
          Text(
            "No Data",
            style: context.textTheme.headline3!.copyWith(fontSize: 20),
          ),
          10.0.height,
          Text(
            "Looks like there are no job here..",
            textAlign: TextAlign.center,
            style: context.textTheme.headline6!.copyWith(color: Colors.grey),
          ).paddingSymmetric(horizontal: 20),
          40.0.height,
        ],
      ),
    );
  }
}
