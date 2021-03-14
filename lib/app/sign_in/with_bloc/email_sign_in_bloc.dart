import 'dart:async';

import 'package:time_tracker_flutter_course/app/sign_in/with_bloc/email_sign_in_model.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({this.auth});
  final Auth auth;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  EmailSignInModel _model = EmailSignInModel();

  void toggelFormType() {
    updateWith(
      email: '',
      password: '',
      isLoading: false,
      submeted: false,
      formType: _model.toggelFormType,
    );
  }

  Future<void> submit() async {
    updateWith(
      isLoading: true,
      submeted: true,
    );
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void dispose() {
    _modelController.close();
  }

  void updateWith({
    String email,
    String password,
    bool isLoading,
    bool submeted,
    EmailSignInFormType formType,
  }) {
    _model = _model.copyWith(
      email: email,
      password: password,
      isLoading: isLoading,
      submeted: submeted,
      formType: formType,
    );
    _modelController.add(_model);
  }
}
