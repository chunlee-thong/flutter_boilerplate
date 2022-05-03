import 'auth_response.dart';

class SocialAuthData {
  late AuthResponse authResponse;
  final String? accessToken;
  final String? authId;

  SocialAuthData({required this.accessToken, required this.authId});
}
