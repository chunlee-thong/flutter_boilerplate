///Memory user credential
class UserCredential {
  String? jwtToken;
  String? userId;

  UserCredential._();
  static final UserCredential instance = UserCredential._();

  bool hasValidToken() {
    return jwtToken != null && jwtToken!.isNotEmpty;
  }

  void clearCredential() {
    jwtToken = null;
    userId = null;
  }

  void initLocalCredential({required String? token, required String? userId}) {
    jwtToken = token;
    this.userId = userId;
  }
}
