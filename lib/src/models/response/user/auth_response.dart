class AuthResponse {
  AuthResponse({
    this.userId,
    this.token,
    this.refreshToken,
    this.tokenExpireDate,
  });

  String? userId;
  String? token;
  String? refreshToken;
  int? tokenExpireDate;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        userId: json["user_id"] == null ? null : json["user_id"],
        token: json["token"] == null ? null : json["token"],
        refreshToken: json["refresh_token"] == null ? null : json["refresh_token"],
        tokenExpireDate: json["token_expire_date"] == null ? null : json["token_expire_date"],
      );
}
