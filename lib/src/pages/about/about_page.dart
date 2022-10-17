import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:skadi/skadi.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: Center(
        child: SkadiFutureHandler<PackageInfo>.function(
          futureFunction: () async {
            return PackageInfo.fromPlatform();
          },
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
