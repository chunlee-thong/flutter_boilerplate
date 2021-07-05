import '../utils/service_locator.dart';
import 'repository/user_repository.dart';

final UserRepository userRepository = getIt<UserRepository>();
