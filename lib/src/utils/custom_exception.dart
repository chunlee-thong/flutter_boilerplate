class UserCancelException {
  @override
  String toString() {
    return "User cancel operation, No need to do anything";
  }
}

class SessionExpiredException {
  @override
  String toString() {
    return "Session expired, Please login again";
  }
}
