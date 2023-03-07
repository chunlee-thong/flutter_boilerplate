import '../core/utilities/custom_exception.dart';
import '../models/response/user/social_auth_data.dart';

class SocialAuthService {
  //static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  //static final FacebookAuth _facebookAuth = FacebookAuth.instance;

  Future<SocialAuthData> loginWithFacebook() async {
    //await _facebookAuth.logOut();
    // LoginResult result = await _facebookAuth.login(
    //   loginBehavior: LoginBehavior.nativeWithFallback,
    // );
    // if (result.status == LoginStatus.success) {
    //   return SocialAuthData(
    //     accessToken: result.accessToken!.token,
    //     authId: result.accessToken!.userId,
    //   );
    // } else if (result.status == LoginStatus.failed) {
    //   throw result.message!;
    // }
    throw UserCancelException();
  }

  Future<SocialAuthData> loginWithGoogle() async {
    // await _googleSignIn.signOut();
    // GoogleSignInAccount? account = await _googleSignIn.signIn();
    // if (account == null) throw UserCancelException();
    // GoogleSignInAuthentication authentication = await account.authentication;
    // return SocialAuthData(
    //   accessToken: authentication.accessToken,
    //   authId: authentication.idToken,
    // );
    throw UserCancelException();
  }

  Future<SocialAuthData> loginWithApple() async {
    // try {
    //   final credential = await SignInWithApple.getAppleIDCredential(
    //     scopes: [
    //       AppleIDAuthorizationScopes.email,
    //       AppleIDAuthorizationScopes.fullName,
    //     ],
    //     nonce: nonce,
    //   );
    //   final loginData = SocialAuthData(
    //     accessToken: credential.identityToken,
    //     authId: credential.userIdentifier,
    //   );
    //   return loginData;
    // } on SignInWithAppleAuthorizationException catch (ex) {
    //   if (ex.code == AuthorizationErrorCode.canceled) {
    //     throw UserCancelException();
    //   } else {
    //     throw ex.message;
    //   }
    // } catch (exception) {
    //   rethrow;
    // }
    throw UserCancelException();
  }

  Future<void> signOutAll() async {
    //await _googleSignIn.signOut();
    //await _facebookAuth.logOut();
  }
}
