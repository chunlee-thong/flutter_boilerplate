import 'package:flutter_boiler_plate/src/api/repository/user_repository.dart';

import '../utils/service_locator.dart';
import 'repository/user_repository.dart';

final UserRepository userRepository = getIt<UserRepository>();
