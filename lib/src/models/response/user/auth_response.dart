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
        userId: json["user_id"] ?? null,
        token: json["token"] ?? null,
        refreshToken: json["refresh_token"] ?? null,
      );
}
