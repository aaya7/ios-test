import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/shimmer/shimmerlistview.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_bank_info_view.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_license_info_view.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_personal_info_view.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_product_info_view.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_vehicle_info_view.dart';
import 'package:hero/app/routes/app_pages.dart';

import '../controllers/register_checklist_controller.dart';
import 'checklist_page/checklist_emergency_info_view.dart';

class RegisterChecklistView extends GetView<RegisterChecklistController> {
  const RegisterChecklistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Registration Checklist"),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/registration_checklist.png",
                    height: Get.height * 0.22,
                    width: width,
                    fit: BoxFit.cover,
                  )),
              20.0.height,
              Text(
                "Let's get you started",
                style: context.textTheme.headline3!.copyWith(fontSize: 26),
              ),
              10.0.height,
              Obx(() {
                return Text(
                  "You're ${controller.checklistIncompleteCount.value} steps away from earning with us.",
                  style: context.textTheme.headline6!
                      .copyWith(fontSize: 15, color: Colors.grey),
                );
              }),
              5.0.height,
              Text(
                "The process should take around 10 minutes",
                style: context.textTheme.headline6!
                    .copyWith(fontSize: 15, color: Colors.grey),
              ),
              20.0.height,
              Text(
                "Required Documents",
                style: context.textTheme.headline3!.copyWith(fontSize: 17),
              ),
              15.0.height,
              // Obx(() {
              //   return controller.isLoading.isTrue
              //       ? const ShimmerListView()
              //       : Column(
              //           children: [
              //             ChecklistCard(
              //               title: "Personal Information",
              //               icon: FontAwesomeIcons.idCard,
              //               isDone: controller.checklistStatusModel.value
              //                   .checklistStatuses?.personalInfoChecklist,
              //               onTap: () {
              //                 Get.to(ChecklistPersonalInfoView());
              //               },
              //             ),
              //             15.0.height,
              //             ChecklistCard(
              //               title: "License Information",
              //               icon: FontAwesomeIcons.idBadge,
              //               isDone: controller.checklistStatusModel.value
              //                   .checklistStatuses?.licenseInfoChecklist,
              //               onTap: () {
              //                 Get.to(ChecklistLicenseInfoView());
              //               },
              //             ),
              //             15.0.height,
              //             ListView.builder(
              //               shrinkWrap: true,
              //               itemCount: controller.productChecklistModel.value
              //                       .products?.length ??
              //                   0,
              //               primary: false,
              //               itemBuilder: (context, index) {
              //                 var item = controller
              //                     .productChecklistModel.value.products
              //                     ?.elementAt(index);
              //                 return ChecklistCard(
              //                   title: item?.name ?? '',
              //                   icon: FontAwesomeIcons.briefcase,
              //                   isDone: item?.checklistStatus ?? false,
              //                   onTap: () {
              //                     Get.to(ChecklistProductInfoView(),
              //                         arguments: {"item": item});
              //                   },
              //                 ).marginOnly(bottom: 15);
              //               },
              //             ),
              //             ChecklistCard(
              //               title: "Banking Information",
              //               icon: FontAwesomeIcons.bank,
              //               isDone: controller.checklistStatusModel.value
              //                   .checklistStatuses?.bankInfoChecklist,
              //               onTap: () {
              //                 Get.to(ChecklistBankInfoView());
              //               },
              //             ),
              //             15.0.height,
              //             ChecklistCard(
              //               title: "Emergency Contacts",
              //               icon: FontAwesomeIcons.phone,
              //               isDone: controller
              //                   .checklistStatusModel
              //                   .value
              //                   .checklistStatuses
              //                   ?.emergencyContactInfoChecklist,
              //               onTap: () {
              //                 Get.to(ChecklistEmergencyInfoView());
              //               },
              //             ),
              //             15.0.height,
              //             ChecklistCard(
              //               title: "Vehicle Information",
              //               icon: FontAwesomeIcons.carSide,
              //               isDone: controller.checklistStatusModel.value
              //                   .checklistStatuses?.transportationInfoChecklist,
              //               onTap: () {
              //                 Get.to(ChecklistVehicleInfoView());
              //               },
              //             ),
              //           ],
              //         );
              // }),
            ],
          ).paddingSymmetric(horizontal: width * 0.04, vertical: 10),
        ),
      ),
      // bottomNavigationBar: CommonButton(title: "Continue", callBack: () {})
      //     .marginSymmetric(horizontal: width * 0.04, vertical: 15),
    );
  }
}

class ChecklistCard extends StatelessWidget {
  const ChecklistCard({
    super.key,
    required this.title,
    required this.icon,
    this.isDone,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final bool? isDone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isDone ?? false)
                      ? ColorConstant.primaryColor
                      : Colors.grey[200],
                  border: Border.all(color: Colors.grey)),
              child: (isDone ?? false)
                  ? const Icon(
                      FontAwesomeIcons.check,
                      color: Colors.white,
                      size: 10,
                    )
                  : const SizedBox(
                      width: 10,
                      height: 10,
                    ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black54,
                  size: 15,
                ),
                10.0.width,
                Text(
                  title,
                  style: context.textTheme.headline3!.copyWith(fontSize: 15),
                )
              ],
            ).paddingSymmetric(horizontal: 10),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const Spacer(),
                (isDone ?? false)
                    ? Text(
                        "Done",
                        style: context.textTheme.headline6!
                            .copyWith(color: ColorConstant.primaryColor),
                      )
                    : const Icon(
                        FontAwesomeIcons.chevronRight,
                        size: 15,
                        color: Colors.grey,
                      ),
              ],
            ),
          ),
        ],
      ),
    ).onTap((isDone ?? false) ? null : onTap);
  }
}
