import '../utils/service_locator.dart';
import 'repository/user_repository.dart';

UserRepository get userRepository => getIt<UserRepository>();
