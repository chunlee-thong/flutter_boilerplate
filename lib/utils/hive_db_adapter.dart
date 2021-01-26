import 'package:hive/hive.dart';

import './../models/db/user_model.dart';

void registerHiveAdapter() {
  Hive.registerAdapter(UserAdapter());
}
