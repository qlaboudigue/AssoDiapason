class FieldValidator {

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Champ requis';
    } else if (!regex.hasMatch(value)) {
      return 'L\'adresse mail est invalide';
    } else
      return null;
  }

  static String validateNewPassword(String value) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Champ requis';
    } else if (!regex.hasMatch(value)) {
      return 'Minimum 8 lettres avec majuscule, minuscule et chiffre';
    } else
      return null;
  }

  static String validateExistingPassword(String value) {
    if (value.isEmpty) {
      return 'Champ requis';
    }
    return null;
  }


}