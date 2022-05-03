class AuthResponse {
  AuthResponse({
    required this.userId,
    required this.token,
    required this.refreshToken,
  });

  final String userId;
  final String token;
  final String refreshToken;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        userId: json["user_id"],
        token: json["token"],
        refreshToken: json["refresh_token"],
      );
}
