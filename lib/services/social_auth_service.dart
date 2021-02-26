import '../models/response/user/social_auth_data.dart';

class SocialAuthService {
  static Future<SocialAuthData> loginWithFacebook() async {
    try {
      //Login with facebook
      return SocialAuthData(
        accessToken: "",
        authId: "",
      );
    } catch (exception) {
      throw exception;
    }
  }

  static Future<SocialAuthData> loginWithGoogle() async {
    try {
      //Login with Google
      return SocialAuthData(
        accessToken: "",
        authId: "",
      );
    } catch (exception) {
      throw exception;
    }
  }

  static Future<SocialAuthData> loginWithApple() async {
    try {
      //Login with Apple
      return SocialAuthData(
        accessToken: "",
        authId: "",
      );
    } catch (exception) {
      throw exception;
    }
  }
}
