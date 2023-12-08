

/// A utility class for performing form validations, including email and password validations.
class Validators{

  /// Validates an email address.
  ///
  /// Returns `null` if the email is valid, an error message if it's empty or invalid.
  static emailValidation(String value){
    // Regular expression for validating email addresses.
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return 'Please Enter Email';
    }
    return 'Please enter valid Email';
  }

 static String? validateUsername(String value) {
   if(value.isEmpty || value.trim().length <5){
     return 'Please Enter Character more than 5 characters';
   }
   return null;
  }

  /// Validates a password.
  ///
  /// Returns `null` if the password is valid, an error message if it's empty or too short.
  static String? passwordValidation(String value) {
    if (value.isEmpty || value.trim().length < 3) {
      return 'Please Enter Password more than 3 characters';// Password is empty or too short.
    }
    return null;
  }

  static String? validateRequiredFields(String value) {
    if(value.isEmpty){
      return 'This field is mandatory.';
    }
    return null;
  }
}

class TextFieldValidation {
  static String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
   return '!';
    }

    final RegExp regex = RegExp(
    r'^\d{1,8}(\.\d{0,2})?$',
    );

     if (!regex.hasMatch(value)) {
    return '!';
     }
     return null; // Return null if the input is valid
  }
}