import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:line_icons/line_icons.dart';

import '../../data/constants/constant.dart';

Future<void> openBottomSheet({required List<Widget> children, required String title}) async{
  await Get.bottomSheet(CustomBottomSheet(
    title: title,
    children: children,
  ), isScrollControlled: true, isDismissible: false, enableDrag: false);
}

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.children,
    required this.title,
  });

  final List<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 7,
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.grey[100], shape: BoxShape.circle),
                        child: const Icon(
                          FontAwesomeIcons.xmark,
                          color: Colors.grey,
                          size: 15,
                        ),
                      ).onTap(()=>dismissBottomSheet())
                    ],
                  )
                ],
              ),
              Center(
                child: Text(
                  title,
                  style: context.textTheme.headline3!.copyWith(fontSize: 20),
                ),
              ),
              ...children
            ],
          ),
        ),
      ),
    );
  }
}
