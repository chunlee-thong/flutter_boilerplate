import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/style_decoration.dart';

class CustomErrorDialog extends StatelessWidget {
  final String? message;
  final String? title;
  final Color color = Color(0xFFE57373);
  final double padding = 16.0;
  final RoundedRectangleBorder shape = SuraDecoration.roundRect();
  CustomErrorDialog({Key? key, this.message, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: shape,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildContent(),
          buildAction(context),
        ],
      ),
    );
  }

  Widget buildContent() {
    return Container(
      padding: EdgeInsets.all(padding),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(
            FlutterIcons.warning_ant,
            color: color,
            size: 54,
          ),
          SpaceY(padding),
          Text(title!, style: kSubHeaderStyle),
          SpaceY(padding),
          Text(
            message!,
            style: kSubtitleStyle.normal,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildAction(context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(padding, 0, padding, padding),
      child: Material(
        elevation: 0.0,
        color: color,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Dismiss", style: kSubtitleStyle.medium.white),
            ),
          ),
        ),
      ),
    );
  }
}
