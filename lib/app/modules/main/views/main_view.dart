import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/jobs/views/jobs_view.dart';
import 'package:hero/app/modules/messages/views/messages_view.dart';
import 'package:hero/app/modules/profile/views/profile_view.dart';

import '../../../data/constants/color_constant.dart';
import '../../home/views/home_view.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CommonService.changeStatusBarIconColor(isDark: false);
    return WillPopScope(
      onWillPop: () async{

        if(controller.contentIndex.value == 0){
          return true;
        }else{
          controller.contentIndex.value = 0;
        }

        return false;
      },
      child: Scaffold(
        body: Obx(() {
          return IndexedStack(
            index: controller.contentIndex.value,
            children: const [
              HomeView(),
              JobsView(),
              MessagesView(),
              ProfileView(),
            ],
          );
        }),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: controller.contentIndex.value,
            onTap: (index) => controller.contentIndex(index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorConstant.primaryColor,
            unselectedItemColor: Colors.grey,
            enableFeedback: true,
            showSelectedLabels: true,
            elevation: 0,
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: AnimatedIconBar(
                    isActive: controller.contentIndex.value == 0,
                    iconData: FontAwesomeIcons.house,
                  ),
                  label: 'Home'.tr),
              BottomNavigationBarItem(
                  icon: AnimatedIconBar(
                    isActive: controller.contentIndex.value == 1,
                    iconData: FontAwesomeIcons.solidFile,
                  ), label: 'Jobs'.tr),
              BottomNavigationBarItem(
                  icon: AnimatedIconBar(
                    isActive: controller.contentIndex.value == 2,
                    iconData: FontAwesomeIcons.solidMessage,
                  ), label: "Messages".tr),
              BottomNavigationBarItem(
                  icon: AnimatedIconBar(
                    isActive: controller.contentIndex.value == 3,
                    iconData: FontAwesomeIcons.solidUser,
                  ), label: "Account".tr),
            ],
          );
        }),
      ),
    );
  }
}

class AnimatedIconBar extends GetView<MainController> {
  const AnimatedIconBar({
    super.key,
    required this.isActive,
    required this.iconData,
  });

  final bool isActive;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          width: isActive ? 60 : 0,
          height: 3,
          decoration: BoxDecoration(
              color: isActive ? ColorConstant.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(20)),
          duration: 500.milliseconds,
        ),
        10.0.height,
        Icon(iconData, size: 20,),
        5.0.height,
      ],
    );
  }
}
