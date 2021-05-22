import 'auth_response.dart';

class SocialAuthData {
  AuthResponse? authResponse;
  final String? accessToken;
  final String? authId;

  SocialAuthData({this.authResponse, this.accessToken, this.authId});
}
