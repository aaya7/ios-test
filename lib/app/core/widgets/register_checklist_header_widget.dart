import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/data/constants/extensions/double_extension.dart';

class RegisterChecklistHeaderWidget extends StatelessWidget {
  const RegisterChecklistHeaderWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[400]!)),
          child: Icon(
            icon,
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
                title,
                style: context.textTheme.headline3!.copyWith(fontSize: 20),
              ),
              Text(
                subtitle,
                style: context.textTheme.headline6!.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
