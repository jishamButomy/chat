
class ValidationUtil {


  String? passwordValidation(String? value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return "Enter your password";
    } else {
      if (!regex.hasMatch(value)) {
        return 'Please ensure that your password contains at least one lowercase,one uppercase letter, one digit, one special character (@,\$,!,%,*,?,~,#,^,_,-,/ or &), and is at least 8 characters long';
      } else {
        return null;
      }
    }
  }

  String? confirmPasswordValidation(String? password, String? confirmPassword) {
    if (password!.isEmpty) {
      return "Enter your password";
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? nameValidation(
      String? value,
      ) {
    if (value!.isEmpty) return "Enter Name";
    // return AppLocalizations.of(context)!.plz_enter_password;
    return null;
  }

  String? commonValidation({String? value, String? text}) {
    if (value!.isEmpty) return text ?? 'enter some text';
    // return AppLocalizations.of(context)!.plz_enter_password;
    return null;
  }

  String? dropDownValidation(value) {
    if (value == null) return "Choose something";
    // return AppLocalizations.of(context)!.plz_enter_password;
    return null;
  }

  String? emailValidation(String? email) {
    bool valid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email!);
    print(valid);
    if (email.isEmpty) {
      return 'Please Enter Email';
    } else if (valid == false) {
      return 'Enter Valid email';
    }
    return null;
  }

  String? confirmAccountNumberValidation(
      {String? number, String? confirmNumber}) {
    if (number!.isEmpty) {
      return "Enter Account Number";
    }
    if (number != confirmNumber) {
      return 'Account Number do not match';
    }
    return null;
  }

}
