///Memory user credential
class MemoryUserCredential {
  String? jwtToken;
  String? userId;

  MemoryUserCredential._();
  static final MemoryUserCredential instance = MemoryUserCredential._();

  bool hasValidToken() {
    return this.jwtToken != null && this.jwtToken!.isNotEmpty;
  }

  void clearMemoryCredential() {
    this.jwtToken = null;
    this.userId = null;
  }

  void initMemoryCredential({required String? token, required String? userId}) {
    this.jwtToken = token;
    this.userId = userId;
  }
}
