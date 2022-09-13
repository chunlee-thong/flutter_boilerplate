import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../widgets/ui_helper.dart';

Future launchExternalUrl(String url, BuildContext? context) async {
  if (!url.contains("http") && !url.contains("https")) {
    url = "https://$url";
  }
  try {
    // await launch(
    //   url,
    //   customTabsOption: const CustomTabsOption(
    //     toolbarColor: AppColor.primary,
    //     enableDefaultShare: true,
    //     enableUrlBarHiding: true,
    //     showPageTitle: true,
    //   ),
    //   safariVCOption: const SafariViewControllerOption(
    //     // preferredBarTintColor: Theme.of(context).primaryColor,
    //     preferredControlTintColor: Colors.white,
    //     barCollapsingEnabled: true,
    //     entersReaderIfAvailable: false,
    //     dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
    //   ),
    // );
  } catch (e) {
    if (context != null) {
      UIHelper.showErrorDialog(context, e);
    }
  }
}

Future launchFacebookApp(String? pageId, String fallbackUrl) async {
  if (pageId == null) {
    launchExternalUrl(fallbackUrl, null);
    return;
  }
  String fbProtocolUrl;

  ///on Android,
  if (Platform.isAndroid && pageId.length < 15) {
    fbProtocolUrl = 'fb://page/$pageId';
  } else {
    fbProtocolUrl = 'fb://profile/$pageId';
  }

  try {
    await launchUrlString(
      fbProtocolUrl,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    await launchUrlString(
      fallbackUrl,
      mode: LaunchMode.externalApplication,
    );
  }
}

Future launchOtherSocialApp(String url) async {
  await launchUrlString(
    url,
    mode: LaunchMode.externalApplication,
  );
}

void launchMap(double lat, double lng) async {
  var url = '';
  if (Platform.isAndroid) {
    url = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
  } else {
    url = 'https://maps.apple.com/?q=$lat,$lng';
  }
  await launchUrlString(
    url,
    mode: LaunchMode.externalApplication,
  );
}

void launchPhoneNumber(String phoneNumber) async {
  String number = phoneNumber.replaceAll(" ", "");
  await launchUrlString(
    "tel:$number",
    mode: LaunchMode.externalApplication,
  );
}
