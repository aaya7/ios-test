import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../data/constants/color_constant.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  /**
   *
   * DECLARE  final contentIndex = 0.obs; IN CONTROLLER
   */

  @override
  Widget build(BuildContext context) {
    return  BottomAppBar(
          // shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          child: Obx(() {
            return BottomNavigationBar(
              backgroundColor: Colors.white,

              /**
               *   currentIndex: controller.contentIndex.value,
                  onTap: (index) {
                  controller.contentIndex.value = index;
                  },
               *
               */

              type: BottomNavigationBarType.fixed,
              selectedItemColor: ColorConstant.primaryColor,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: 'Home'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.planeDeparture), label: 'Fly Now'),
                BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        FaIcon(FontAwesomeIcons.book),
                        Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          width: 14,
                          height: 14,
                          child: FittedBox(
                              child: Text('0',
                                  style: TextStyle(color: Colors.white))),
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                        ),
                      ],), label: "Log Book"),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.solidUserCircle),
                    label: "Profile"),
              ],
            );
          }),
        );


  }
}
