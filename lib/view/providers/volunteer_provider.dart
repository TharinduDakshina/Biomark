import 'package:flutter/material.dart';

class VolunteerProvider extends ChangeNotifier {

  String _dob = '';
  String _timeOfBirth = '';
  String _locationOfBirth = '';
  String _bloodGroup = '';
  String _sex = '';
  String _height = '';
  String _ethnicity = '';
  String _eyeColour = '';

  String? _dobError;
  String? _timeOfBirthError;
  String? _locationOfBirthError;
  String? _bloodGroupError;
  String? _sexError;
  String? _heightError;
  String? _ethnicityError;
  String? _eyeColourError;

  String get dob => _dob;
  String? get dobError => _dobError;
  String get timeOfBirth => _timeOfBirth;
  String? get timeOfBirthError => _timeOfBirthError;
  String get locationOfBirth => _locationOfBirth;
  String? get locationOfBirthError => _locationOfBirthError;
  String get bloodGroup => _bloodGroup;
  String? get bloodGroupError => _bloodGroupError;
  String get sex => _sex;
  String? get sexError => _sexError;
  String get height => _height;
  String? get heightError => _heightError;
  String get ethnicity => _ethnicity;
  String? get ethnicityError => _ethnicityError;
  String get eyeColour => _eyeColour;
  String? get eyeColourError => _eyeColourError;

  void validateFields() {
    _dobError = _dob.isEmpty ? 'Please enter your date of birth' : null;
    _timeOfBirthError = _timeOfBirth.isEmpty ? 'Please enter your time of birth' : null;
    _locationOfBirthError = _locationOfBirth.isEmpty ? 'Please enter your location of birth' : null;
    _bloodGroupError = _bloodGroup.isEmpty ? 'Please enter your blood group' : null;
    _sexError = _sex.isEmpty ? 'Please enter your sex' : null;
    _heightError = _height.isEmpty ? 'Please enter your height' : null;
    _ethnicityError = _ethnicity.isEmpty ? 'Please enter your ethnicity' : null;
    _eyeColourError = _eyeColour.isEmpty ? 'Please enter your eye colour' : null;

    notifyListeners();
  }

  void updateDob(String value) {
    _dob = value;
    notifyListeners();
  }

  void updateTimeOfBirth(String value) {
    _timeOfBirth = value;
    notifyListeners();
  }

  void updateLocationOfBirth(String value) {
    _locationOfBirth = value;
    notifyListeners();
  }

  void updateBloodGroup(String value) {
    _bloodGroup = value;
    notifyListeners();
  }

  void updateSex(String value) {
    _sex = value;
    notifyListeners();
  }

  void updateHeight(String value) {
    _height = value;
    notifyListeners();
  }

  void updateEthnicity(String value) {
    _ethnicity = value;
    notifyListeners();
  }

  void updateEyeColour(String value) {
    _eyeColour = value;
    notifyListeners();
  }
}
