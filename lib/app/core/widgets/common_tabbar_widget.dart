import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/constants/color_constant.dart';

class CommonTabBarWidget extends StatelessWidget {
  const CommonTabBarWidget({
    super.key,
    required this.tabController,
    required this.tabBarList,
    this.isEnabled,
  });

  final TabController tabController;
  final List<Widget> tabBarList;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      padding: const EdgeInsets.all(5),
      height: 40,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
      child: Theme(
        data: context.theme.copyWith(
          colorScheme: context.theme.colorScheme.copyWith(
            surfaceVariant: Colors.transparent,
          ),
        ),
        child: IgnorePointer(
          ignoring: !(isEnabled ?? true),
          child: TabBar(
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
            ),
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            unselectedLabelColor:
                (isEnabled ?? true) ? Colors.black54 : Colors.grey[400],
            labelColor: ColorConstant.primaryColor,
            labelStyle: context.textTheme.headline3!,
            tabs: tabBarList,
          ),
        ),
      ),
    );
  }
}
