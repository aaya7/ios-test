import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/core/language/bottomsheet_choose_lang.dart';
import 'package:hero/app/core/widgets/common_button.dart';
import 'package:hero/app/core/widgets/info_dialog.dart';
import 'package:hero/app/data/constants/constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/text_style_extensions.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/quiz_onboarding_result_model.dart';
import 'package:hero/app/modules/main/controllers/main_controller.dart';
import 'package:hero/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/constants/color_constant.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

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
            ProfileAppBar(width: width),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.0.height,
                Text(
                  "Account".tr,
                  style: context.textTheme.headline3!.copyWith(fontSize: 17),
                ),
                20.0.height,
                ProfileMenuCard(
                  icon: FontAwesomeIcons.idCard,
                  title: "Personal Information".tr,
                  onTap: () => Get.toNamed(Routes.PERSONAL_INFO),
                ),
                ProfileMenuCard(
                  icon: FontAwesomeIcons.sliders,
                  title: "Work Preferences".tr,
                  onTap: () => Get.toNamed(Routes.WORK_PREFERENCE),
                ),
                ProfileMenuCard(
                  icon: FontAwesomeIcons.gear,
                  title: "Account Management".tr,
                  onTap: () => Get.toNamed(Routes.ACCOUNT_MANAGEMENT),
                ),
                // ProfileMenuCard(
                //   icon: FontAwesomeIcons.shieldHalved,
                //   title: "Sign In & Security".tr,
                //   onTap: () => Get.toNamed(Routes.SIGN_IN_SECURITY),
                // ),
                ProfileMenuCard(
                  icon: FontAwesomeIcons.globe,
                  title: "Language".tr,
                  onTap: () => showChooseLangBottomSheet(),
                ),
                ProfileMenuCard(
                  icon: FontAwesomeIcons.bell,
                  title: "Notifications".tr,
                  onTap: () => Get.toNamed(Routes.NOTIFICATION_SETTING),
                ),
                // ProfileMenuCard(
                //   icon: FontAwesomeIcons.message,
                //   title: "Contact & FAQ",
                // ),
              ],
            ).paddingSymmetric(horizontal: width * 0.04),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonButton(
            title: "Log out".tr,
            callBack: () {
              Get.dialog(InfoDialog(
                title: "Sign Out",
                info: "Are you sure want to logout this user?",
                confirmText: "Logout",
                cancelText: "Cancel",
                confirmCallback: () {
                  LocalDBService.instance.clearDB();
                  Get.offAllNamed(Routes.SPLASH);
                },
              ));
            },
            buttonColor: Colors.white,
            buttonTextColor: ColorConstant.primaryColor,
            border: Colors.grey,
          ),
          10.0.height,
          Obx(() {
            return Text(
              "App version".tr + " v${controller.versionName.value}",
              style: context.textTheme.headline6!
                  .copyWith(color: Color(0xff525252)),
            );
          }),
          10.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bugs? ".tr,
                style:
                    context.textTheme.headline6!.copyWith(color: Colors.grey),
              ),
              Text(
                "Send feedback ".tr,
                style: context.textTheme.headline6!
                    .copyWith(color: ColorConstant.primaryColor),
              ),
              Text(
                "to us".tr,
                style:
                    context.textTheme.headline6!.copyWith(color: Colors.grey),
              ),
            ],
          ).onTap(() async {
            if (await canLaunchUrl(Uri.parse('https://wa.me/601155067083'))) {
              launchUrl(Uri.parse('https://wa.me/601155067083'),
                  mode: LaunchMode.externalApplication);
            }
          }),
        ],
      ).paddingSymmetric(horizontal: width * 0.05, vertical: 10),
    );
  }
}

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black54,
                size: 16,
              ),
              15.0.width,
              Text(
                title,
                style: context.textTheme.headline5!.copyWith(),
              ),
              const Spacer(),
              const Icon(
                FontAwesomeIcons.chevronRight,
                color: Colors.black54,
                size: 16,
              ),
            ],
          ),
        ).onTap(onTap),
        const Divider(
          thickness: 0.2,
          color: Colors.grey,
        ),
        // 10.0.height,
      ],
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
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
                        headers: imageNetworkHeader));
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
          ),
          10.0.width,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Obx(() {
                    return Text(
                      Get.find<MainController>().profileModel.value.name ??
                          LocalDBService.instance.getUsername(),
                      style: context.textTheme.headline3,
                    );
                  }),
                  5.0.width,
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 10,
                  //   ),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(16),
                  //       border: Border.all(color: ColorConstant.primaryColor)),
                  //   child: Text(
                  //     "PART TIME",
                  //     style: context.textTheme.headline5!.copyWith(
                  //         color: ColorConstant.primaryColor, fontSize: 13),
                  //   ),
                  // )
                ],
              ),
              5.0.height,
              Row(
                children: [
                  Icon(
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
