import 'package:hive/hive.dart';

import './../model/db/user_model.dart';

void registerHiveAdapter() {
  Hive.registerAdapter(UserAdapter());
}
