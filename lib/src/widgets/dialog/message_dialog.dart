import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_assets.dart';
import '../../constant/app_theme_color.dart';
import '../../constant/app_style_decoration.dart';
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

  final RoundedRectangleBorder shape = SuraDecoration.roundRect();
  final double padding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: shape,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildContent(),
          _buildAction(context),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final iconData = _isError ? AppAssets.FATAL_ERROR : AppAssets.NOTIFICATION;
    return Container(
      padding: EdgeInsets.all(padding),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgAsset(
                icon: iconData,
                size: 32,
                iconColor: _isError ? Colors.red : Colors.green,
              ),
              const SpaceX(16),
              Text(title, style: kSubHeaderStyle.medium),
            ],
          ),
          SpaceY(padding),
          Text(
            message,
            style: kSubtitleStyle.normal,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAction(context) {
    final buttonText = _isError ? "Dismiss" : "Ok";
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(padding, 0, padding, padding),
      child: Material(
        elevation: 0.0,
        color: _color,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(buttonText, style: kSubtitleStyle.medium.white),
            ),
          ),
        ),
      ),
    );
  }
}
