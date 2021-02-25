class AuthResponse {
  final String userId;
  final String token;

  AuthResponse({this.userId, this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      userId: json["user_id"] == null ? null : json["user_id"],
      token: json["token"] == null ? null : json["token"],
    );
  }
}
