import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import '../../data/constants/color_constant.dart';
import 'info_dialog.dart';

class ImagePickerDialog extends StatelessWidget {
  final VoidCallback cameraCallback;
  final VoidCallback galleryCallback;
  const ImagePickerDialog({Key? key, required this.cameraCallback, required this.galleryCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoDialog(
      confirmText: 'Kamera',
      cancelText: 'Galeri Gambar',
      cancelButtonColor: ColorConstant.secondaryColor,
      icon: LottieBuilder.asset('assets/lottie/choose_photo.json'),
      info: 'Sila piih pilihan di bawah',
      title: 'Ambil Gambar',
      confirmIcon: LineIcons.camera,
      cancelIcon: LineIcons.imageAlt,
      confirmCallback: cameraCallback,
      cancelCallback: galleryCallback,
    );
  }
}
