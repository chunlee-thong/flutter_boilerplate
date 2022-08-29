import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skadi/skadi.dart';

import '../../core/style/color.dart';
import '../../core/style/decoration.dart';
import '../../core/utilities/exception_handler.dart';
import 'avatar_image.dart';

class UserAvatar extends StatefulWidget {
  final String? imageUrl;
  final double radius;
  final Future<void> Function(File?)? onImageChanged;

  const UserAvatar({
    Key? key,
    required this.imageUrl,
    required this.onImageChanged,
    required this.radius,
  }) : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> with BoolNotifierMixin {
  File? selectedImage;
  final picker = ImagePicker();

  void onChooseProfileImageSource() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => SkadiActionSheet<String>(
        title: tr("Please choose your image source"),
        cancelText: tr("Cancel"),
        builder: (String option, index) => Text(option),
        onSelected: (String name, index) {
          if (index == 0) {
            onPickImage(ImageSource.camera);
          } else if (index == 1) {
            onPickImage(ImageSource.gallery);
          }
        },
        options: [tr("Camera"), tr("Gallery")],
      ),
    );
  }

  Future onPickImage(ImageSource imageSource) async {
    await ExceptionHandler.run(
      context,
      () async {
        final pickedFile = await picker.pickImage(source: imageSource, maxWidth: 1000);
        if (pickedFile != null) {
          toggleValue(true);
          await widget.onImageChanged?.call(selectedImage);
          selectedImage = File(pickedFile.path);
        }
      },
    );
    toggleValue(false);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: boolNotifier,
      builder: (context, isLoading, child) => GestureDetector(
        onTap: isLoading ? null : onChooseProfileImageSource,
        child: Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [kGreyShadow2],
          ),
          child: Stack(
            children: [
              ConditionalWidget(
                condition: selectedImage != null,
                onTrue: () => AvatarImage.file(
                  radius: widget.radius,
                  fileImage: FileImage(selectedImage!),
                ),
                onFalse: () => AvatarImage(
                  radius: widget.radius,
                  imageUrl: widget.imageUrl,
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                top: 0,
                bottom: 0,
                child: ConditionalWidget(
                  condition: isLoading,
                  onTrue: () => const CircularProgressIndicator(),
                  onFalse: () => emptySizedBox,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: ConditionalWidget(
                  condition: isLoading,
                  onTrue: () => emptySizedBox,
                  onFalse: () => SkadiIconButton(
                    icon: Icon(
                      widget.imageUrl == null ? Icons.add : Icons.edit,
                      color: AppColor.primary,
                      size: 20,
                    ),
                    padding: const EdgeInsets.all(4),
                    onTap: onChooseProfileImageSource,
                    borderRadius: 32,
                    backgroundColor: Colors.white,
                    elevation: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
