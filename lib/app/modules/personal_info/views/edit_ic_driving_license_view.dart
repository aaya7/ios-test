import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';

import '../../../core/widgets/common_button.dart';
import '../../../data/constants/color_constant.dart';
import '../controllers/personal_info_controller.dart';

class EditIcDrivingLicenseView extends GetView<PersonalInfoController> {
  const EditIcDrivingLicenseView(this.isIc, {Key? key}) : super(key: key);

  final bool isIc;

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: isIc? "NRIC Details" : "Driving License Details"),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.0.height,
              Row(
                children: [
                  Text(
                    "NRIC Front",
                    style:
                    context.textTheme.headline3!.copyWith(fontSize: 17),
                  ),
                  Text(
                    "",
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.orange, fontSize: 17),
                  ),
                ],
              ),
              5.0.height,
              const Text("Photo of the IC must be clearly visible. Scanned or photocopied is not accepted as well."),
              20.0.height,
              SizedBox(
                width: width,
                child: Column(
                  children: [
                    Container(
                      width: Get.width * 0.45,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.image,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                    10.0.height,
                    SizedBox(
                      width: width * 0.4,
                      child: CommonButton(
                        title: "Take Photo",
                        callBack: () {},
                        border: Colors.grey[400],
                        buttonTextColor: ColorConstant.primaryColor,
                        buttonColor: Colors.white,
                        iconData: FontAwesomeIcons.camera,
                      ),
                    ),
                    10.0.height,
                    SizedBox(
                      width: width * 0.4,
                      child: CommonButton(
                        title: "Upload",
                        callBack: () {},
                        border: Colors.grey[400],
                        buttonTextColor: ColorConstant.primaryColor,
                        buttonColor: Colors.white,
                        iconData: FontAwesomeIcons.upload,
                      ),
                    ),


                  ],
                ),
              ),
              20.0.height,
              const Divider(thickness: 0.5, color: Colors.grey,),
              20.0.height,
              Row(
                children: [
                  Text(
                    "NRIC Back",
                    style:
                    context.textTheme.headline3!.copyWith(fontSize: 17),
                  ),
                  Text(
                    "",
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.orange, fontSize: 17),
                  ),
                ],
              ),
              5.0.height,
              const Text("Photo of the IC must be clearly visible. Scanned or photocopied is not accepted as well."),
              20.0.height,
              SizedBox(
                width: width,
                child: Column(
                  children: [
                    Container(
                      width: Get.width * 0.45,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.image,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                    10.0.height,
                    SizedBox(
                      width: width * 0.4,
                      child: CommonButton(
                        title: "Take Photo",
                        callBack: () {},
                        border: Colors.grey[400],
                        buttonTextColor: ColorConstant.primaryColor,
                        buttonColor: Colors.white,
                        iconData: FontAwesomeIcons.camera,
                      ),
                    ),
                    10.0.height,
                    SizedBox(
                      width: width * 0.4,
                      child: CommonButton(
                        title: "Upload",
                        callBack: () {},
                        border: Colors.grey[400],
                        buttonTextColor: ColorConstant.primaryColor,
                        buttonColor: Colors.white,
                        iconData: FontAwesomeIcons.upload,
                      ),
                    ),


                  ],
                ),
              ),
              20.0.height,
              const Divider(thickness: 0.5, color: Colors.grey,),
              20.0.height,
              Row(
                children: [
                  Text(
                    "Selfie with NRIC",
                    style:
                    context.textTheme.headline3!.copyWith(fontSize: 17),
                  ),
                  Text(
                    "",
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.orange, fontSize: 17),
                  ),
                ],
              ),
              5.0.height,
              const Text("Need help on the copywriting for this one"),
              20.0.height,
              SizedBox(
                width: width,
                child: Column(
                  children: [
                    Container(
                      width: Get.width * 0.45,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.image,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                    10.0.height,
                    SizedBox(
                      width: width * 0.4,
                      child: CommonButton(
                        title: "Take Photo",
                        callBack: () {},
                        border: Colors.grey[400],
                        buttonTextColor: ColorConstant.primaryColor,
                        buttonColor: Colors.white,
                        iconData: FontAwesomeIcons.camera,
                      ),
                    ),
                    10.0.height,
                    SizedBox(
                      width: width * 0.4,
                      child: CommonButton(
                        title: "Upload",
                        callBack: () {},
                        border: Colors.grey[400],
                        buttonTextColor: ColorConstant.primaryColor,
                        buttonColor: Colors.white,
                        iconData: FontAwesomeIcons.upload,
                      ),
                    ),
                    40.0.height,

                  ],
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: width * 0.04),
        ),
      ),
      bottomNavigationBar: CommonButton(title: "Save", callBack: (){

      }).paddingSymmetric(horizontal: width * 0.05, vertical: 15),
    );
  }
}
