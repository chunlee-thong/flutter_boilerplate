import '../models/response/user/social_auth_data.dart';

class SocialAuthService {
  //static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  static Future<SocialAuthData> loginWithFacebook() async {
    try {
      //Login with facebook
      return SocialAuthData(
        accessToken: "",
        authId: "",
      );
    } catch (exception) {
      rethrow;
    }
  }

  static Future<SocialAuthData> loginWithGoogle() async {
    try {
      // await _googleSignIn.signOut();
      // GoogleSignInAccount? account = await _googleSignIn.signIn();
      // if (account == null) throw UserCancelException();
      // GoogleSignInAuthentication authentication = await account.authentication;
      // return SocialAuthData(
      //   accessToken: authentication.accessToken,
      //   authId: authentication.idToken,
      // );
      return SocialAuthData(
        accessToken: "",
        authId: "",
      );
    } catch (exception) {
      rethrow;
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
      rethrow;
    }
  }

  static Future<void> signOutAll() async {
    //await _googleSignIn.signOut();
  }
}
