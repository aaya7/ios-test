import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/account_management/controllers/account_management_controller.dart';

import '../../../core/widgets/common_appbar.dart';
import '../../../core/widgets/common_button.dart';
import '../../../data/constants/color_constant.dart';
import '../../../data/constants/extensions/text_style_extensions.dart';

class PayslipDetailView extends GetView<AccountManagementController> {
  const PayslipDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Payslip Detail"),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xffE5FAE6),
                        border: Border.all(
                          color: const Color(0xffD1F6D2),
                        ),
                        shape: BoxShape.circle),
                    child: const Icon(
                      FontAwesomeIcons.fileInvoiceDollar,
                      color: ColorConstant.primaryColor,
                      size: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payslip P000075",
                        style:
                            context.textTheme.headline2!.copyWith(fontSize: 26),
                      ),
                      5.0.height,
                      Text(
                        "CYCLE 25/11/2022 - 01/12/2022",
                        style: secondaryTextStyle(size: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            20.0.height,
            Text(
              "Summary",
              style: context.textTheme.headline3!.copyWith(fontSize: 17),
            ),
            20.0.height,
            const Row(
              children: [
                Expanded(
                  child: TitleDescriptionWidget(
                    title: 'RECEIVED ON',
                    subtitle: "25 Nov 2022",
                  ),
                ),
                Expanded(
                  child: TitleDescriptionWidget(
                    title: 'NET EARNINGS',
                    subtitle: "+ RM 754.00",
                    textColor: ColorConstant.primaryColor,
                  ),
                ),
              ],
            ),
            20.0.height,
            const Row(
              children: [
                Expanded(
                  child: TitleDescriptionWidget(
                    title: 'PROCESSING CODE',
                    subtitle: "P00075",
                  ),
                ),
                Expanded(
                  child: TitleDescriptionWidget(
                    title: 'STATUS',
                    subtitle: "PROCESSED",
                  ),
                ),
              ],
            ),
            20.0.height,
            Text(
              "POD SLIP",
              style: context.textTheme.headline3!
                  .copyWith(color: Colors.grey, fontSize: 13),
            ),
            20.0.height,
            CommonButton(
              title: "Download Payslip",
              callBack: () {},
              iconData: FontAwesomeIcons.fileArrowDown,
              border: Colors.grey[400],
              buttonTextColor: ColorConstant.primaryColor,
              buttonColor: Colors.grey[100],
            ),
            10.0.height,
            Text(
              " You can view or download this Payslip on your device for reference.",
              style: context.textTheme.headline6!
                  .copyWith(color: Colors.grey, fontSize: 13),
              textAlign: TextAlign.center,
            )
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}

class TitleDescriptionWidget extends StatelessWidget {
  const TitleDescriptionWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.textColor,
  });

  final String title;
  final String subtitle;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.headline3!
              .copyWith(color: Colors.grey, fontSize: 13),
        ),
        Text(
          subtitle,
          style: context.textTheme.headline3!
              .copyWith(fontSize: 18, color: textColor),
        )
      ],
    );
  }
}
