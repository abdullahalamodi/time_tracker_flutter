import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/with_change_notifire/email_sign_in_form_with_change_notifire.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInFormWithChangeNotifire.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
