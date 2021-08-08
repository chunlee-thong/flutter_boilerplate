import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
import '../../constant/style_decoration.dart';
import '../../utils/exception_handler.dart';
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
      builder: (context) => SuraActionSheet(
        title: tr("Please choose your image source"),
        cancelText: tr("Cancel"),
        builder: (dynamic option, index) => Text(option),
        onSelected: (dynamic name, index) {
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
    await ExceptionWatcher(context, () async {
      final pickedFile = await picker.pickImage(source: imageSource, maxWidth: 1000);
      if (pickedFile != null) {
        toggleValue(true);
        await widget.onImageChanged?.call(selectedImage);
        selectedImage = File(pickedFile.path);
      }
    }, onDone: () {});
    toggleValue(false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChooseProfileImageSource,
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [greyShadow2],
        ),
        child: Stack(
          children: [
            selectedImage != null
                ? AvatarImage.file(
                    radius: widget.radius,
                    fileImage: FileImage(selectedImage!),
                  )
                : AvatarImage(
                    radius: widget.radius,
                    imageUrl: widget.imageUrl,
                  ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SuraIconButton(
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
            Positioned(
              right: 0,
              left: 0,
              top: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SuraNotifier<bool>(
                  valueNotifier: boolNotifier,
                  builder: (isLoading) {
                    return ConditionalWidget(
                      condition: isLoading,
                      onTrue: () => CircularProgressIndicator(),
                      onFalse: () => SizedBox(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
