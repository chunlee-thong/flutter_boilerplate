import 'package:logger/logger.dart';

import '../../../flavor.dart';

late Logger logger;

void initLogger(Flavor flavor) {
  logger = Logger(
    printer: PrettyPrinter(
      printEmojis: false,
      methodCount: 0,
      colors: false,
    ),
  );
  Logger.level = Level.debug;
}

final Logger httpResponseLogger = Logger(
  printer: PrettyPrinter(
    errorMethodCount: 0,
    methodCount: 0,
    printEmojis: false,
    colors: false,
    noBoxingByDefault: true,
  ),
);
