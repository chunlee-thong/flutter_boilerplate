class LocalUserCredential {
  String? jwtToken;
  String? userId;

  bool hasValidToken() {
    return this.jwtToken != null && this.jwtToken!.isNotEmpty;
  }

  void clearLocalCredential() {
    this.jwtToken = null;
    this.userId = null;
  }

  void initLocalCrendential({required String? token, required String? userId}) {
    this.jwtToken = token;
    this.userId = userId;
  }
}
