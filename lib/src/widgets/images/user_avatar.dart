import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
import '../../constant/style_decoration.dart';
import '../../providers/user_provider.dart';
import '../../utils/custom_exception.dart';
import 'avatar_image.dart';

class UserAvatar extends StatefulWidget {
  final String image;
  final double radius;
  final Future<void> Function(File) onImageChanged;
  final bool currentUser;

  const UserAvatar({
    Key key,
    @required this.image,
    @required this.onImageChanged,
    this.radius = 50.0,
    this.currentUser = false,
  }) : super(key: key);

  const UserAvatar.currentUser({
    Key key,
    @required this.image,
    @required this.onImageChanged,
    this.radius = 20.0,
    this.currentUser = true,
  }) : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> with NotifierMixin {
  File selectedImage;
  final picker = ImagePicker();

  // try {
  //   final pickedFile = await picker.getImage(source: imageSource, maxWidth: 1000);
  //   toggleLoading();
  //   if (pickedFile != null) {
  //     selectedImage = File(pickedFile.path);
  //     print(selectedImage.path);
  //     await widget.onImageChanged?.call(selectedImage);
  //   }
  // } catch (exception) {
  //   selectedImage = null;
  //   UIHelper.showErrorMessageDialog(context, exception);
  // } finally {
  //   toggleLoading();
  //   setState(() {});
  // }

  void onChooseProfileImageSource() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => SuraActionSheet(
        title: tr("Please choose your image source"),
        cancelText: tr("Cancel"),
        builder: (option, index) => Text(option),
        onSelected: (name, index) {
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
    await exceptionWatcher(context, () async {
      final pickedFile = await picker.getImage(source: imageSource, maxWidth: 1000);
      toggleLoading();
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        await widget.onImageChanged?.call(selectedImage);
      }
    }, onDone: () {
      toggleLoading();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentUser) {
      UserProvider userProvider = UserProvider.getProvider(context);
      return AvatarImage(
        imageUrl: userProvider.userData.avatar,
        radius: widget.radius,
        elevation: 1.0,
      );
    }

    return GestureDetector(
      onTap: onChooseProfileImageSource,
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [greyShadow],
        ),
        child: Stack(
          children: [
            selectedImage != null
                ? AvatarImage.file(
                    radius: widget.radius,
                    fileImage: FileImage(selectedImage),
                  )
                : AvatarImage(
                    radius: widget.radius,
                    imageUrl: widget.image,
                  ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SuraIconButton(
                icon: Icon(
                  widget.image == null ? Icons.add : Icons.edit,
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
                  valueNotifier: loadingNotifier,
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
