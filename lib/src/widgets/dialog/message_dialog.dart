import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_assets.dart';
import '../../constant/app_style_decoration.dart';
import '../../constant/app_theme_color.dart';
import '../../widgets/images/svg_asset.dart';

class CustomMessageDialog extends StatelessWidget {
  final String message;
  final String title;
  final bool _isError;
  final Color _color;

  CustomMessageDialog({
    Key? key,
    required this.message,
    this.title = "Information",
  })  : _isError = false,
        _color = AppColor.primary,
        super(key: key);

  CustomMessageDialog.error({
    Key? key,
    this.title = "Information",
    required this.message,
  })  : _isError = true,
        _color = const Color(0xFFE57373),
        super(key: key);

  final RoundedRectangleBorder shape = SuraDecoration.roundRect(16);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: shape,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildContent(),
            const SpaceY(12),
            _buildAction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final iconData = _isError ? AppAssets.fatalError : AppAssets.notification;
    return Column(
      children: [
        SvgAsset(
          icon: iconData,
          size: 40,
          padding: EdgeInsets.zero,
          iconColor: _isError ? Colors.red : Colors.green,
        ),
        const SpaceY(16),
        Text(title, style: kSubHeaderStyle.medium),
        const SpaceY(4),
        Text(
          message,
          style: kNormalStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAction(context) {
    final buttonText = _isError ? "Dismiss" : "Ok";
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          primary: _color,
        ),
        child: Text(
          buttonText,
          style: kSubtitleStyle.medium.white,
        ),
      ),
    );
  }
}
