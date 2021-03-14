import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInBloc {
  SignInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<bool> _isLoodingController = StreamController<bool>();

  Stream get isLoodingStream => _isLoodingController.stream;

  void despose() {
    _isLoodingController.close();
  }

  void _setIsLooding(bool isLooding) => _isLoodingController.add(isLooding);

  Future<User> signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLooding(true);
      return await signInMethod();
    } catch (e) {
      _setIsLooding(false);
      rethrow;
    }
  }

  Future<User> signInAnonymously() => signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() => signIn((auth.signInWithGoogle));

  Future<User> signInWithFacebook() => signIn(auth.signInWithFacebook);

  void showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }
}
