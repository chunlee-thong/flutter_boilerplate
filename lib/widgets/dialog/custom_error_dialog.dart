import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/style_decoration.dart';

class CustomErrorDialog extends StatelessWidget {
  final String message;
  final String title;
  final Color color = Color(0xFFE57373);
  final double padding = 12.0;
  CustomErrorDialog({Key key, this.message, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: SuraStyle.roundRect(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildHeader(),
          SpaceY(padding),
          ...buildInfo(context),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: SuraStyle.radiusTop(),
        color: color,
      ),
      padding: EdgeInsets.all(padding),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(FlutterIcons.emoji_sad_ent, color: Colors.white, size: 54),
          SpaceY(12),
          Text(title, style: kTitleStyle.white),
        ],
      ),
    );
  }

  List<Widget> buildInfo(context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
      SuraRaisedButton(
        margin: EdgeInsets.symmetric(vertical: padding),
        onPressed: () => Navigator.pop(context),
        color: color,
        elevation: 0.0,
        child: Text("OKAY"),
      ),
    ];
  }
}
