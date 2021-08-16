///Memory user credential
class MemoryUserCredential {
  String? jwtToken;
  String? userId;

  MemoryUserCredential._();
  static final MemoryUserCredential instance = MemoryUserCredential._();

  bool hasValidToken() {
    return jwtToken != null && jwtToken!.isNotEmpty;
  }

  void clearMemoryCredential() {
    jwtToken = null;
    userId = null;
  }

  void initMemoryCredential({required String? token, required String? userId}) {
    jwtToken = token;
    this.userId = userId;
  }
}
