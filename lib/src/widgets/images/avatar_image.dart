import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skadi/skadi.dart';

import '../../core/style/color.dart';
import '../../core/utilities/app_utils.dart';

class AvatarImage extends StatelessWidget {
  final double radius;
  final double elevation;
  final String? imageUrl;
  final ImageProvider? fileImage;
  final IconData? placeHolderIcon;
  //
  const AvatarImage({
    Key? key,
    required this.imageUrl,
    this.radius = 20,
    this.fileImage,
    this.elevation = 3.0,
    this.placeHolderIcon,
  }) : super(key: key);

  const AvatarImage.file({
    Key? key,
    this.radius = 20,
    required this.fileImage,
    this.imageUrl,
    this.elevation = 3.0,
    this.placeHolderIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? realImageUrl = AppUtils.getFileUrl(imageUrl);
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
      onTrue: () => _buildCircleAvatarImage(fileImage),
      onFalse: () => realImageUrl == null
          ? placeholder
          : CachedNetworkImage(
              imageUrl: realImageUrl,
              useOldImageOnUrlChange: false,
              errorWidget: (context, url, _) => placeholder,
              placeholder: (context, url) => placeholder,
              imageBuilder: (context, image) {
                return _buildCircleAvatarImage(image);
              },
            ),
    );
  }

  Widget _buildCircleAvatarImage(ImageProvider? image) {
    return Card(
      color: Colors.white,
      shape: const CircleBorder(),
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
