import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/modules/main/controllers/main_controller.dart';
import 'package:hero/app/modules/personal_info/views/bank_info_view.dart';
import 'package:hero/app/modules/personal_info/views/ic_driving_license_view.dart';
import 'package:hero/app/modules/personal_info/views/name_contact_detail_view.dart';
import 'package:hero/app/modules/personal_info/views/personal_contact_view.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_bank_info_view.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_emergency_info_view.dart';
import 'package:hero/app/modules/register_checklist/views/checklist_page/checklist_personal_info_view.dart';

import '../../../core/services/common_services.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/common_image_placeholder.dart';
import '../../../core/widgets/custom_bottom_sheet.dart';
import '../../../data/constants/color_constant.dart';
import '../../register_checklist/views/checklist_page/checklist_license_info_view.dart';
import '../../register_checklist/views/checklist_page/checklist_vehicle_info_view.dart';
import '../controllers/personal_info_controller.dart';

class PersonalInfoView extends GetView<PersonalInfoController> {
  const PersonalInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Personal Information".tr),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.0.height,
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[400]!)),
                  child: Icon(
                    FontAwesomeIcons.idCard,
                    color: Colors.black54,
                    size: 18,
                  ),
                ),
                20.0.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Information".tr,
                      style:
                          context.textTheme.headline3!.copyWith(fontSize: 20),
                    ),
                    Text(
                      "View or edit your personal infos.".tr,
                      style:
                          context.textTheme.headline6!.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            30.0.height,
            ProfileContentMenuCard(
              title: "Name & Contact Details".tr,
              onTap: () => Get.to(
                () => ChecklistPersonalInfoView(),
              ),
            ),
            ProfileContentMenuCard(
                title: "Profile Picture".tr,
                onTap: () async {
                  await openBottomSheet(children: [
                    10.0.height,
                    Center(
                      child: Text(
                        "Change your profile picture by pick your photo from option below".tr,
                        textAlign: TextAlign.center,
                        style: Get.context!.textTheme.headline6!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          20.0.height,
                          CommonImagePlaceholder(
                            imageString: Get.find<MainController>().profileModel.value.profilePhotoImageUrl ?? '',
                            imageFile: controller.profilePicture,
                            width: Get.width * 0.4,
                            height: Get.width * 0.4,
                          ),
                          10.0.height,
                          SizedBox(
                            width: Get.width * 0.4,
                            child: CommonButton(
                              title: "Take Photo".tr,
                              callBack: () {
                                CommonService.pickImageC(image: (_) {
                                  controller.profilePicture.value = _;
                                });
                              },
                              border: Colors.grey[400],
                              buttonTextColor: ColorConstant.primaryColor,
                              buttonColor: Colors.white,
                              iconData: FontAwesomeIcons.camera,
                            ),
                          ),
                          10.0.height,
                          SizedBox(
                            width: Get.width * 0.4,
                            child: CommonButton(
                              title: "Upload".tr,
                              callBack: () {
                                CommonService.pickImage(image: (_) {
                                  controller.profilePicture.value = _;
                                });
                              },
                              border: Colors.grey[400],
                              buttonTextColor: ColorConstant.primaryColor,
                              buttonColor: Colors.white,
                              iconData: FontAwesomeIcons.upload,
                            ),
                          ),
                          20.0.height,
                          CommonButton(title: "Save".tr, callBack: (){
                            controller.uploadProfilePhoto();
                          }),
                        ],
                      ),
                    ),
                    30.0.height,
                  ], title: "Upload Profile Photo".tr);

                  controller.profilePicture.value = null;

                }),
            ProfileContentMenuCard(
              title: "Driving License".tr,
              onTap: () => Get.to(() => ChecklistLicenseInfoView()),
            ),
            ProfileContentMenuCard(
              title: "Transportation Details".tr,
              onTap: () => Get.to(() => ChecklistVehicleInfoView()),
            ),
            ProfileContentMenuCard(
              title: "Emergency Contacts".tr,
              onTap: () => Get.to(() => ChecklistEmergencyInfoView()),
            ),
            ProfileContentMenuCard(
              title: "Bank Info".tr,
              onTap: () => Get.to(
                () => ChecklistBankInfoView(),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}

class ProfileContentMenuCard extends StatelessWidget {
  const ProfileContentMenuCard({
    super.key,
    this.subtitle,
    required this.title,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: context.textTheme.headline5!
                      .copyWith(color: Colors.black54),
                ),
                const Spacer(),
                const Icon(
                  FontAwesomeIcons.chevronRight,
                  color: Colors.black54,
                  size: 16,
                ),
              ],
            ),
            subtitle != null
                ? Text(
                    subtitle ?? '',
                    style: context.textTheme.headline6!.copyWith(),
                  ).paddingOnly(top: 10)
                : const SizedBox.shrink(),
            10.0.height,
          ],
        ).onTap(onTap),
        const Divider(
          thickness: 0.2,
          color: Colors.grey,
        ),
        10.0.height,
      ],
    );
  }
}
