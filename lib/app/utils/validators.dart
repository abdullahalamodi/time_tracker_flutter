abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class RatePerHourNumberValidator {
  bool isValid(int value) {
    print(value);
    return (value > 0 && value < 50) ? true : false;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}

class JobValidators {
  final StringValidator nameValidator = NonEmptyStringValidator();
  final RatePerHourNumberValidator ratePerHourValidator =
      RatePerHourNumberValidator();
  final String invalidNameErrorText = 'Name can\'t be empty';
  final String invalidRateErrorText =
      'RatePerHour can\'t be empty or more than 50';
}
