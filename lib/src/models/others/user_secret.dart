class UserSecret {
  String? jwtToken;
  String? userId;

  UserSecret._();
  static final UserSecret instance = UserSecret._();

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
