import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:line_icons/line_icons.dart';

import '../../data/constants/color_constant.dart';
import '../services/local_db_services/local_db_services.dart';
import 'localization_services.dart';

void showChooseLangBottomSheet(){
  final context = Get.context!;
  final width = Get.width;

  final languageList = LocalizationService.langs;
  final languageSelected =
      LocalDBService.instance.getLanguage().obs;
  Get.bottomSheet(
      ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: Container(
          width: width,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.0.height,
              Row(
                children: [
                  const Icon(
                    LineIcons.globe,
                    size: 40,
                  ),
                  5.0.width,
                  Text(
                    'Language'.tr,
                    style: context.textTheme.headline2,
                  ),
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 20),
                  itemCount: languageList.length,
                  itemBuilder: (_, index) {
                    var item =
                    languageList.elementAt(index);
                    return Obx(() {
                      return ListTile(
                        title: Text(
                          item,
                          style: context
                              .textTheme.headline6!
                              .copyWith(
                              color: Colors.black54,
                              fontSize: 15),
                        ),
                        trailing:
                        languageSelected.value == item
                            ? const Icon(
                          LineIcons.check,
                          color: ColorConstant
                              .primaryColor,
                        )
                            : const SizedBox.shrink(),
                        onTap: () {
                          languageSelected.value = item;
                          LocalizationService.changeLocale(
                              item);
                          Get.back();
                        },
                      );
                    });
                  })
            ],
          ).paddingSymmetric(
              horizontal: width * 0.04, vertical: 10),
        ),
      ),
      isScrollControlled: true);
}