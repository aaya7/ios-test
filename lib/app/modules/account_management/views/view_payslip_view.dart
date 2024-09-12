import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/comming_soon_widget.dart';
import 'package:hero/app/data/constants/color_constant.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:hero/app/modules/account_management/controllers/account_management_controller.dart';
import 'package:hero/app/modules/account_management/views/payslip_detail_view.dart';

import '../../../core/widgets/common_appbar.dart';
import '../../personal_info/views/personal_info_view.dart';

class ViewPayslipView extends GetView<AccountManagementController> {
  const ViewPayslipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Payslips"),
      body: ComingSoonWidget(
        child: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.0.height,
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[400]!)),
                    child: Icon(
                      FontAwesomeIcons.fileInvoiceDollar,
                      color: Colors.black54,
                      size: 18,
                    ),
                  ),
                  20.0.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payslips",
                        style:
                            context.textTheme.headline3!.copyWith(fontSize: 20),
                      ),
                      Text(
                        "View records of your payslips.",
                        style:
                            context.textTheme.headline6!.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              30.0.height,
              Expanded(child: ListView.builder(
                itemCount: 5,
                itemBuilder: (_, index){
                return PayslipMenuCard();
              },),),

            ],
          ).paddingSymmetric(horizontal: width * 0.04),
        ),
      ),
    );
  }
}

class PayslipMenuCard extends StatelessWidget {
  const PayslipMenuCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.0.height,
          Row(
            children: [
              Expanded(
                flex: 1,
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
                      style: context.textTheme.headline3,
                    ),
                    5.0.height,
                    Text(
                      "Cycle 25/11/2022 - 01/12/2022",
                      style: context.textTheme.headline6!.copyWith(color: Colors.grey),
                    )
                  ],
                ).paddingSymmetric(horizontal: 14),
              ),
              const Expanded(
                  flex: 1,
                  child: Icon(
                    FontAwesomeIcons.chevronRight,
                    size: 12,
                    color: Colors.grey,
                  ))
            ],
          ),
          5.0.height,
          const Divider(color: Colors.grey, thickness: 0.3,)
        ],
      ).onTap(()=>Get.to(()=>const PayslipDetailView())),
    );
  }
}
