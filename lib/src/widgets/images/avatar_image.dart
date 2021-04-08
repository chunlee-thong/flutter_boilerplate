import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
import '../../utils/app_utils.dart';

class AvatarImage extends StatelessWidget {
  final double radius;
  final String imageUrl;
  final ImageProvider fileImage;
  final double elevation;
  final IconData placeHolderIcon;
  //
  const AvatarImage({
    Key key,
    @required this.imageUrl,
    this.radius = 20,
    this.fileImage,
    this.elevation = 3.0,
    this.placeHolderIcon,
  }) : super(key: key);

  const AvatarImage.file({
    this.radius = 20,
    @required this.fileImage,
    this.imageUrl,
    this.elevation = 3.0,
    this.placeHolderIcon,
  });

  @override
  Widget build(BuildContext context) {
    final String realImageUrl = AppUtils.getFileUrl(imageUrl);
    final placeholder = Card(
      shape: const CircleBorder(),
      elevation: elevation,
      margin: EdgeInsets.zero,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        child: Icon(placeHolderIcon ?? Icons.person, color: AppColor.primary, size: radius),
      ),
    );
    return ConditionalWidget(
      condition: fileImage != null,
      onTrue: () => buildCircleAvatarImage(fileImage),
      onFalse: () => realImageUrl == null
          ? placeholder
          : CachedNetworkImage(
              imageUrl: realImageUrl,
              useOldImageOnUrlChange: false,
              errorWidget: (context, url, _) => placeholder,
              placeholder: (context, url) => placeholder,
              imageBuilder: (context, image) {
                return buildCircleAvatarImage(image);
              },
            ),
    );
  }

  Widget buildCircleAvatarImage(ImageProvider image) {
    return Card(
      color: Colors.white,
      shape: const StadiumBorder(),
      elevation: elevation,
      margin: EdgeInsets.zero,
      child: CircleAvatar(
        backgroundImage: image,
        radius: radius,
        backgroundColor: Colors.grey.withOpacity(0.8),
      ),
    );
  }
}
