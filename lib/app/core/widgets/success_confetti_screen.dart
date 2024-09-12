import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../data/constants/color_constant.dart';
import 'common_button.dart';

class SuccessConfettiScreen extends StatefulWidget {
  final String? highLightedText;
  final String? message;
  final VoidCallback? onNext;

  const SuccessConfettiScreen(
      {Key? key, this.highLightedText, this.onNext, this.message})
      : super(key: key);

  @override
  State<SuccessConfettiScreen> createState() => _SuccessConfettiScreenState();
}

class _SuccessConfettiScreenState extends State<SuccessConfettiScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    // _confettiController.play();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  minimumSize: Size(10, 10),
                  maximumSize: Size(10, 10),
                  shouldLoop: false,
                  colors: [
                    ColorConstant.secondaryColor,
                    ColorConstant.primaryColor,
                  ],
                ),
              ),

              LottieBuilder.asset("assets/lottie/lottie_success.json"),
              // SizedBox(height: 20.0),
              Text('Tahniah !',
                  style: TextStyle(
                      fontSize: Get.width * 0.062,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 15.0),
              widget.message != null
                  ? Text(widget.message ?? '',
                      style: TextStyle(
                          fontSize: Get.width * 0.103,
                          color: ColorConstant.primaryColor,
                          fontWeight: FontWeight.w600))
                  : const SizedBox.shrink(),
              widget.message != null
                  ? const SizedBox.shrink()
                  : Row(
                      children: [

                        Text(widget.highLightedText ?? 'Permintaan',
                            style: context.textTheme.headline3!.copyWith(
                                fontSize: Get.width * 0.09,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.primaryColor)),
                      ],
                    ),
              widget.message != null
                  ? const SizedBox.shrink()
                  : Text(
                      'Anda Telah Berjaya Dihantar',
                      style: context.textTheme.headline3!.copyWith(
                        fontSize: Get.width * 0.09,
                      ),
                    ),
              SizedBox(height: Get.height * 0.1),
              CommonButton(
                  title: 'OKAY',
                  callBack: widget.onNext ??
                      () {
                        Get.back();
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
