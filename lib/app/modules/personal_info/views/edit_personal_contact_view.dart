import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';

import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/common_textfield.dart';
import '../../../data/constants/color_constant.dart';
import '../controllers/personal_info_controller.dart';

class EditPersonalContactView extends GetView<PersonalInfoController> {
  const EditPersonalContactView({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: title, action: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.edit,
              size: 15,
            ))
      ]),
      body: SizedBox(
        width: width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Details",
                style: context.textTheme.headline3!.copyWith(fontSize: 17),
              ),
              20.0.height,
              Text(
                "Contact Name",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonTextField(
                  hintText: "Enter contact name", title: "Contact Name"),
              20.0.height,
              Text(
                "NRIC",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonTextField(hintText: "Enter NRIC number", title: "NRIC"),
              20.0.height,
              Text(
                "Mobile Number",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonTextField(
                hintText: "",
                title: "Mobile Number",
                prefixIconData: LayoutBuilder(builder: (context, constraint) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (constraint.maxWidth * 0.03).width,
                      Text(
                        "+60",
                        style: context.textTheme.headline6!
                            .copyWith(color: Colors.black54),
                      ),
                      (constraint.maxWidth * 0.03).width,
                      Container(
                        height: 50,
                        width: 0.5,
                        color: Colors.grey,
                      )
                    ],
                  );
                }),
              ),
              20.0.height,
              Text(
                "Email",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonTextField(hintText: "Enter email address", title: "Email"),
              20.0.height,
              Text(
                "Residential Address",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonTextField(
                hintText: "Enter residential address",
                title: "Residential Address",
                minLines: 5,
                maxLines: 10,
              ),
              20.0.height,
              Text(
                "Relationship",
                style: context.textTheme.headline6!
                    .copyWith(color: Colors.black54),
              ),
              5.0.height,
              CommonTextField(
                  hintText: "Enter relationship with contact",
                  title: "Relationship"),
              20.0.height,
              const Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              20.0.height,
              Row(
                children: [
                  Text(
                    "NRIC Front",
                    style: context.textTheme.headline3!.copyWith(fontSize: 17),
                  ),
                  Text(
                    "",
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.orange, fontSize: 17),
                  ),
                ],
              ),
              5.0.height,
              const Text(
                  "Photo of the IC must be clearly visible. Scanned or photocopied is not accepted as well."),
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
              const Divider(
                thickness: 0.5,
                color: Colors.grey,
              ),
              20.0.height,
              Row(
                children: [
                  Text(
                    "NRIC Back",
                    style: context.textTheme.headline3!.copyWith(fontSize: 17),
                  ),
                  Text(
                    "",
                    style: context.textTheme.headline6!
                        .copyWith(color: Colors.orange, fontSize: 17),
                  ),
                ],
              ),
              5.0.height,
              const Text(
                  "Photo of the IC must be clearly visible. Scanned or photocopied is not accepted as well."),
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
            ],
          ).paddingSymmetric(horizontal: width * 0.04),
        ),
      ),
      bottomNavigationBar: CommonButton(title: "Save", callBack: () {})
          .paddingSymmetric(horizontal: width * 0.05, vertical: 15),
    );
  }
}
