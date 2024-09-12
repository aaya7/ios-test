import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import '../../data/constants/extensions/widget_extensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../data/constants/color_constant.dart';
import '../services/common_services.dart';

PreferredSizeWidget CommonAppBar(
    {required BuildContext context,
    required String title,
    final Color? bgColor,
    final double? elevation,
    final Color? textColor,
    final bool? hasBackButton,
    final VoidCallback? backOnTap,
    final action}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness:
            CommonService.isDarkColor(bgColor ?? ColorConstant.white)
                ? Brightness.light
                : Brightness.dark,
        statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        statusBarIconBrightness:
            CommonService.isDarkColor(bgColor ?? ColorConstant.white)
                ? Brightness.light
                : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            CommonService.isDarkColor(bgColor ?? ColorConstant.white)
                ? Brightness.light
                : Brightness.dark,
      ),
      title: Text(
        title,
        style: context.textTheme.headline3!.copyWith(
            color: textColor ?? ColorConstant.textPrimaryColor,
            fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: bgColor ?? Colors.transparent,
      elevation: elevation ?? 0,
      leading: hasBackButton ?? true
          ? const BackButton()
          : const SizedBox.shrink(),
      actions: action,
    ),
  );
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key, this.textColor, this.backOnTap,
  });

  final Color? textColor;
  final VoidCallback? backOnTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Row(
            children: [
              (constraint.maxWidth * 0.15).width,
              Icon(
                FontAwesomeIcons.chevronLeft,
                color: textColor ?? ColorConstant.primaryColor,
                size: constraint.maxWidth * 0.25,
              ),
              (constraint.maxWidth * 0.02).width,
              Text(
                'Back'.tr,
                style: context.textTheme.headline6!
                    .copyWith(color: ColorConstant.primaryColor, fontSize: constraint.maxWidth * 0.25),
              )
            ],
          );
      }
    ).onTap(backOnTap ?? () => Get.back());
  }
}
