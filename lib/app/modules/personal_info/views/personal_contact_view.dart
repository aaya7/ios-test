import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_appbar.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';
import 'package:hero/app/modules/personal_info/views/edit_personal_contact_view.dart';
import 'package:hero/app/modules/personal_info/views/personal_info_view.dart';

import '../controllers/personal_info_controller.dart';

class PersonalContactView extends GetView<PersonalInfoController> {
  const PersonalContactView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Scaffold(
      appBar: CommonAppBar(context: context, title: "Personal Contacts"),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.0.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[400]!)),
                  child: Icon(
                    FontAwesomeIcons.phone,
                    color: Colors.black54,
                    size: 18,
                  ),
                ),
                20.0.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal Contact",
                        style:
                        context.textTheme.headline3!.copyWith(fontSize: 20),
                      ),
                      Text(
                        "For any emergency cases, we would need 2 personal contacts. This can be your next of kin or your family.",
                        style:
                        context.textTheme.headline6!.copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            30.0.height,
            ProfileContentMenuCard(
              title: "First Contact",
              subtitle: "Ali bin Abu",
              onTap: () => Get.to(
                    () => EditPersonalContactView(title: 'First Contact',),
              ),
            ),
            ProfileContentMenuCard(
              title: "Second Contact",
              subtitle: "Maryam Fatimah",
              onTap: () => Get.to(() => EditPersonalContactView(title: 'Second Contact',)),
            ),
          ],
        ).paddingSymmetric(horizontal: width * 0.04),
      ),
    );
  }
}
