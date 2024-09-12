import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/constants/color_constant.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback callBack;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final IconData? iconData;
  final bool? isDisabled;
  final Color? border;
  final String? imageIcon;

  CommonButton({
    Key? key,
    required this.title,
    required this.callBack,
    this.buttonColor,
    this.iconData,
    this.buttonTextColor,
    this.isDisabled,
    this.border,
    this.imageIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled ?? false ? () {} : callBack,
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
          surfaceTintColor: isDisabled ?? false
              ? const Color(0xFFFFCCAB)
              : buttonColor ?? ColorConstant.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: border != null
                ? BorderSide(color: border ?? ColorConstant.primaryColor)
                : BorderSide.none,
          ),
          backgroundColor: isDisabled ?? false
              ? const Color(0xFFFFCCAB)
              : buttonColor ?? ColorConstant.primaryColor),
      child: Container(
        height: Get.height * 0.06,
        child: Center(
          child: title.isEmpty
              ? Center(
                  child: iconData != null
                      ? Icon(
                          iconData,
                          color: isDisabled ?? false
                              ? Colors.white
                              : buttonTextColor ?? Colors.white,
                        )
                      : Container(),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    iconData != null
                        ? Icon(
                            iconData,
                            color: isDisabled ?? false
                                ? Colors.white
                                : buttonTextColor ?? Colors.white,
                          ).marginOnly(right: Get.width * 0.03)
                        : Container(),
                    imageIcon != null
                        ? Image.asset(
                            imageIcon ?? '',
                            width: 20,
                            height: 20,
                          ).marginOnly(right: Get.width * 0.03)
                        : Container(),
                    Text(
                      title,
                      style: context.textTheme.headline3!.copyWith(
                        color: isDisabled ?? false
                            ? Colors.white
                            : buttonTextColor ?? Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
