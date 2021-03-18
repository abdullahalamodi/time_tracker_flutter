import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter_course/app/sign_in/with_bloc/email_sign_in_model.dart';
import 'package:time_tracker_flutter_course/app/utils/validators.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

//also called contoller or viewmodel
class EmailSignInChangeNotifireModel
    with EmailAndPasswordValidators, ChangeNotifier {
  String email;
  String password;
  bool isLoading;
  bool submitted;
  EmailSignInFormType formType;
  final Auth auth;

  EmailSignInChangeNotifireModel({
    @required this.auth,
    this.email: '',
    this.password: '',
    this.isLoading: false,
    this.submitted: false,
    this.formType: EmailSignInFormType.signIn,
  });

  String get primaryText =>
      formType == EmailSignInFormType.signIn ? 'Sign in' : 'Create an account';
  String get secondaryText => formType == EmailSignInFormType.signIn
      ? 'Need an account? Register'
      : 'Have an account? Sign in';

  bool get submitEnabled => validEmail && validPassword && !isLoading;
  bool get validEmail => emailValidator.isValid(email);
  bool get validPassword => passwordValidator.isValid(password);
  EmailSignInFormType get toggelFormType =>
      formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
  String get showEmailErrorText =>
      (submitted && !validEmail) ? invalidEmailErrorText : null;
  String get showPasswordErrorText =>
      (submitted && !validPassword) ? invalidPasswordErrorText : null;

  void toggelFormTypeFunction() {
    updateWith(
      email: '',
      password: '',
      isLoading: false,
      submeted: false,
      formType: toggelFormType,
    );
  }

  Future<void> submit() async {
    updateWith(
      isLoading: true,
      submeted: true,
    );
    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.createUserWithEmailAndPassword(email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void updateWith(
      {String email,
      String password,
      bool isLoading,
      bool submeted,
      EmailSignInFormType formType}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submeted ?? this.submitted;
    this.formType = formType ?? this.formType;
    notifyListeners();
  }
}
