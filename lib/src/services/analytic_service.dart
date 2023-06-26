import 'package:flutter/material.dart';

enum AnalyticEvent {
  change_theme,
  change_language,
}

void logClickEvent(AnalyticEvent event) {
  // if (MatomoTracker.instance.initialized) {
  //   MatomoTracker.instance.trackEvent(
  //     eventCategory: "Setting",
  //     action: "Click",
  //     eventName: event.name,
  //   );
  // }
}

void logScreen(Route route) {
  // if (MatomoTracker.instance.initialized) {
  //   String? screenName = route.settings.name;
  //   if (screenName != null) {
  //     MatomoTracker.instance.trackScreenWithName(
  //       widgetName: screenName,
  //       eventName: "screen",
  //     );
  //   }
  // }
}
