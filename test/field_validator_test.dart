import 'package:diapason/util/field_validator.dart';
import 'package:test/test.dart';

void main() {

  // Email tests
  test('Empty email test', (){
    var result = FieldValidator.validateEmail('');
    expect(result, 'Champ requis');
  });

  test('Invalid email test', () {
    var result = FieldValidator.validateEmail('qlaboudigue');
    expect(result, 'L\'adresse mail est invalide');
  });

  // New password tests
  test('Empty new password test', () {
    var result = FieldValidator.validateNewPassword('');
    expect(result, 'Champ requis');
  });

  test('Invalid new password test', () {
    var result = FieldValidator.validateNewPassword('azerty');
    expect(result, 'Minimum 8 lettres avec majuscule, minuscule et chiffre');
  });

  // Existing password tests
  test('Empty existing password test', () {
    var result = FieldValidator.validateExistingPassword('');
    expect(result, 'Champ requis');
  });



}