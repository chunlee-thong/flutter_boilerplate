import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:skadi/skadi.dart';

import '../../core/constant/locale_keys.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.about_us.tr())),
      body: Center(
        child: SkadiFutureHandler<PackageInfo>.function(
          futureFunction: PackageInfo.fromPlatform,
          ready: (data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Flutter Boilerplate"),
                const SpaceY(),
                Text("Version: ${data.version}"),
              ],
            );
          },
        ),
      ),
    );
  }
}
