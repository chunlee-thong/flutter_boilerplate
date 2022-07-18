import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../core/constant/app_assets.dart';
import '../../core/style/color.dart';
import '../../core/style/textstyle.dart';
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
    ///280 is a default dialog width from Material spec
    final double dialogWidth = max(context.screenSize.width / 2, 280);
    return Dialog(
      shape: shape,
      child: Container(
        width: dialogWidth,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0.0),
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
    final iconData = _isError ? AppAssets.error : AppAssets.info;
    return Column(
      children: [
        SvgAsset.iconOnly(
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
    final buttonText = _isError ? "Dismiss" : "Okay";
    return TextButton(
      onPressed: () => Navigator.pop(context),
      style: TextButton.styleFrom(
        primary: _color,
      ),
      child: Text(buttonText),
    );
  }
}
