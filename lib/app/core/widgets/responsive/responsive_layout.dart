import 'package:flutter/material.dart';

import '../../../data/constants/responsive_constant.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  ResponsiveLayout({required this.mobileBody, required this.desktopBody});

  @override
  Widget build(BuildContext context) {
        if (Responsive.isMobile(context)) {
          return mobileBody;
        } else if(Responsive.isDesktop(context)){
          return desktopBody;
        }

        return Container();
  }
}