class UserCancelException {
  @override
  String toString() {
    return "User cancel operation, No need to do anything";
  }
}

class SessionLogoutException {
  @override
  String toString() {
    return "Session expired, Please login again";
  }
}
