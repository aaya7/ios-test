import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../../../data/constants/constant.dart';
import '../../../data/constants/extensions/double_extension.dart';
import '../../../data/constants/extensions/widget_extensions.dart';
import 'package:get/get.dart';

import '../../../data/constants/color_constant.dart';
import '../../../data/constants/extensions/text_style_extensions.dart';

/**
 *
 * TUKAR 'extends StatelessWidget > GetView<(nama_controller)>
 *
 */

class CustomDrawerNavigation extends StatelessWidget {
  final Widget body;
  const CustomDrawerNavigation({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final advancedDrawerController = AdvancedDrawerController();
    return AdvancedDrawer(
      backdropColor: ColorConstant.primaryColor,
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.menu_rounded).onTap((){
            advancedDrawerController.showDrawer();
          }),
        ),
        body: body
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    width: 128.0,
                    height: 128.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 24.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                      'https://pbs.twimg.com/profile_images/1086701730161664001/Cl2Lf6Ya_400x400.jpg',
                      width: Get.width * 0.1,
                      height: Get.width * 0.1,
                      httpHeaders: imageNetworkHeader,
                    )),

                Text('Haziq Shukor', style: boldTextStyle(color: ColorConstant.white, size: Get.height * 0.035),),
                (70.0).height,
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.home),
                  title: Text('Home', style: primaryTextStyle(color: ColorConstant.white, size: Get.height * 0.03),),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title:Text('Profile', style: primaryTextStyle(color: ColorConstant.white, size: Get.height * 0.03),),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.history),
                  title: Text('History', style: primaryTextStyle(color: ColorConstant.white, size: Get.height * 0.03),),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings', style: primaryTextStyle(color: ColorConstant.white, size: Get.height * 0.03),),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
