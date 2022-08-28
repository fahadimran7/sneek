class Validators {
  static validateEmail(email) {
    if (email == null || email.isEmpty) {
      return 'Email Address cannot be empty';
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Enter a valid Email Address';
    }
    return null;
  }

  static validatePassword(password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }

    if (password.length < 6) {
      return "Password must be 6 characters";
    }
    return null;
  }
}
