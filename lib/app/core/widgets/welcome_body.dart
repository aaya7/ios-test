import 'package:flutter/material.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/welcome_bg.png",
            width: width,
            height: height * 0.5,
            fit: BoxFit.cover,
          ),
          Container(
            width: width,
            height: height * 0.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0.6),
                ],
              ),
            ),
          ),
          SizedBox(width: width, child: child)
        ],
      ),
    );
  }
}
