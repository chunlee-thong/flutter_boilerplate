import 'package:google_sign_in/google_sign_in.dart';

import '../models/response/user/social_auth_data.dart';
import '../utils/custom_exception.dart';

class SocialAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

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
      await _googleSignIn.signOut();
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) throw UserCancelException();
      GoogleSignInAuthentication authentication = await account.authentication;
      return SocialAuthData(
        accessToken: authentication.accessToken,
        authId: authentication.idToken,
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

  static Future<void> signOutAll() async {
    await _googleSignIn.signOut();
  }
}
