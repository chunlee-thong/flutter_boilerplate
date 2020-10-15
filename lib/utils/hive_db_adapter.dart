import './../model/db/user_model.dart';
import 'package:hive/hive.dart';

void registerHiveAdapter() {
  Hive.registerAdapter(UserAdapter());
}
