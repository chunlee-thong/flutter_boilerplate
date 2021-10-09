import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_theme_color.dart';
import '../../constant/style_decoration.dart';

class CustomMessageDialog extends StatelessWidget {
  final String message;
  final String? title;
  final double padding = 16.0;
  final RoundedRectangleBorder shape = SuraDecoration.roundRect();
  final bool _isError;
  final Color _color;

  CustomMessageDialog({
    Key? key,
    this.title,
    required this.message,
  })  : _isError = false,
        _color = AppColor.primary,
        super(key: key);

  CustomMessageDialog.error({
    Key? key,
    this.title,
    required this.message,
  })  : _isError = true,
        _color = const Color(0xFFE57373),
        super(key: key);

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
    final iconData = _isError ? FlutterIcons.warning_ant : FlutterIcons.infocirlce_ant;
    return Container(
      padding: EdgeInsets.all(padding),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: _color,
                size: 32,
              ),
              const SpaceX(16),
              Text(title ?? "Information", style: kSubHeaderStyle.medium),
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
