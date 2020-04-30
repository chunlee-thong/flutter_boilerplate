import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final Widget loading;
  final Widget error;
  final double width;
  final double height;
  const ImageLoader(
      {Key key,
      this.imageUrl,
      this.fit = BoxFit.cover,
      this.loading,
      this.error,
      this.width,
      this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorWidget: (context, err, obj) {
        if (error != null) return error;
        return Icon(Icons.error_outline);
      },
      placeholder: (context, data) {
        if (loading != null) return loading;
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
