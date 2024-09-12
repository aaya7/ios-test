import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hero/app/data/constants/extensions/widget_extensions.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';

import '../../data/constants/constant.dart';
import 'info_dialog.dart';

class CommonImagePlaceholder extends StatelessWidget {
  CommonImagePlaceholder({
    super.key,
    this.imageFile,
    required this.imageString,
    this.width,
    this.height,
    this.deleteCallback,
  });

  final Rxn<File>? imageFile;
  String imageString;
  final double? width;
  final double? height;
  final Future<bool> Function(bool)? deleteCallback;

  @override
  Widget build(BuildContext context) {
    var reactiveStringImage = imageString.obs;
    return SizedBox(
      width: width != null ? ((width ?? 0) + 20) : Get.width * 0.47,
      height: height != null ? ((height ?? 0) + 20) : 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: width ?? Get.width * 0.45,
            height: height ?? 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey[300],
                child: Obx(() {
                  return imageFile != null
                      ? imageFile?.value != null
                          ? Image.file(
                              imageFile!.value!,
                              fit: BoxFit.cover,
                            )
                          : Obx(() {
                              return Image.network(
                                reactiveStringImage.value,
                                fit: BoxFit.cover,
                                headers: imageNetworkHeader,
                                errorBuilder: (_, __, ___) {
                                  return const Center(
                                    child: Icon(
                                      FontAwesomeIcons.image,
                                      color: Colors.grey,
                                      size: 35,
                                    ),
                                  );
                                },
                              );
                            })
                      : Obx(() {
                          return Image.network(
                            reactiveStringImage.value,
                            fit: BoxFit.cover,
                            headers: imageNetworkHeader,
                            errorBuilder: (_, __, ___) {
                              return const Center(
                                child: Icon(
                                  FontAwesomeIcons.image,
                                  color: Colors.grey,
                                  size: 35,
                                ),
                              );
                            },
                          );
                        });
                }),
              ).onTap(() {
                showImageViewer(
                    context,
                    imageFile != null
                        ? imageFile?.value != null
                            ? FileImage(imageFile!.value!) as ImageProvider
                            : NetworkImage(
                                reactiveStringImage.value, headers: imageNetworkHeader)
                        : NetworkImage(reactiveStringImage.value, headers: imageNetworkHeader),
                    immersive: false,
                    useSafeArea: true,
                    swipeDismissible: true,
                    doubleTapZoomable: true);
              }),
            ),
          ),
          Obx(() {
            var imageURLEmpty = reactiveStringImage.value.isEmpty;
            return Positioned(
              right: 0,
              top: 0,
              child: deleteCallback == null
                  ? const SizedBox.shrink()
                  : (imageFile == null && imageURLEmpty)
                      ? const SizedBox.shrink()
                      : (imageFile?.value == null && imageURLEmpty)
                          ? const SizedBox.shrink()
                          : Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: const Icon(
                                LineIcons.trash,
                                color: Colors.white,
                              ),
                            ).onTap(() {
                              Get.dialog(InfoDialog(
                                title: "Delete Image",
                                info:
                                    "Once you tap 'DELETE' button, this image will permanently delete forever. Are you sure want to proceed?",
                                confirmText: "DELETE",
                                icon: LottieBuilder.asset(
                                  "assets/lottie/delete.json",
                                  height: 100,
                                ),
                                confirmButtonColor: Colors.redAccent,
                                confirmCallback: () async{
                                  dismissDialog();
                                  if (deleteCallback != null) {
                                    bool hasDeleted =
                                        await deleteCallback?.call(false) ?? false;

                                    if (hasDeleted) {
                                      if (imageFile != null &&
                                          imageString.isNotEmpty) {
                                        if (imageFile?.value != null) {
                                          imageFile?.value = null;
                                          return;
                                        }
                                      }

                                      if (imageFile != null &&
                                          imageString.isEmpty) {
                                        if (imageFile?.value != null) {
                                          imageFile?.value = null;
                                          return;
                                        }
                                      }

                                      if (imageFile != null) {
                                        if (imageFile?.value == null) {
                                          reactiveStringImage.value = "";
                                          return;
                                        }
                                      }
                                    }
                                  }
                                },
                                cancelText: "CANCEL",
                              ));
                            }),
            );
          }),
        ],
      ),
    );
  }
}
