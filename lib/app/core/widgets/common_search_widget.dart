import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';

import '../../data/constants/color_constant.dart';

class CommonSearchWidget extends StatelessWidget {
  const CommonSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstant.primaryDarkColor),
            child: const Icon(
              LineIcons.search,
              color: Colors.white,
              size: 15,
            ),
          ),
          10.0.width,
          Text(
            "Search",
            style:
            context.textTheme.headline6!.copyWith(color: Colors.grey),
          ),
          const Spacer(),
          const Icon(
            LineIcons.horizontalSliders,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}