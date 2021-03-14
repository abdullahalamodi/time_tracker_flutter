import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators {
  final String email;
  final String password;
  final bool isLoading;
  final bool submitted;
  final EmailSignInFormType formType;

  EmailSignInModel({
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

  EmailSignInModel copyWith(
      {String email,
      String password,
      bool isLoading,
      bool submeted,
      EmailSignInFormType formType}) {
    return EmailSignInModel(
        email: email ?? this.email,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        submitted: submeted ?? this.submitted,
        formType: formType ?? this.formType);
  }
}
