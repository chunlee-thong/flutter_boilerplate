class AuthResponse {
  AuthResponse({
    this.userId,
    this.token,
    this.refreshToken,
  });

  String? userId;
  String? token;
  String? refreshToken;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        userId: json["user_id"],
        token: json["token"],
        refreshToken: json["refresh_token"],
      );
}
