import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();
  static int _retryCount = 3;

  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    // bool biometricsEnabled = await localStorage.getBool("biometricsEnabled");
    try {
      if (!await _canAuthenticate()) return false;
      bool authenticated;
      for (int i = 0; i < _retryCount; i++) {
        authenticated = await _auth.authenticate(
          localizedReason: 'Use Biometrics to authenticate',
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Oops! Biometric authentication required!',
              cancelButton: 'No thanks',
            ),
            IOSAuthMessages(
              cancelButton: "No thanks",
            ),
          ],
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
        if (authenticated) return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error $e");
      return false;
    }
  }
}
