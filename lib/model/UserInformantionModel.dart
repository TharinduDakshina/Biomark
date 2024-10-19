class UserInformationModel {
  // Private variables
  String? _dateOfBirth;
  String? _timeOfBirth;
  String? _locationOfBirth;
  String? _bloodGroup;
  String? _sex;
  String? _height;
  String? _ethnicity;
  String? _eyeColour;

  // Constructor
  UserInformationModel({
    String? dateOfBirth,
    String? timeOfBirth,
    String? locationOfBirth,
    String? bloodGroup,
    String? sex,
    String? height,
    String? ethnicity,
    String? eyeColour,
  }) {
    _dateOfBirth = dateOfBirth;
    _timeOfBirth = timeOfBirth;
    _locationOfBirth = locationOfBirth;
    _bloodGroup = bloodGroup;
    _sex = sex;
    _height = height;
    _ethnicity = ethnicity;
    _eyeColour = eyeColour;
  }

  // Getters
  String? get dateOfBirth => _dateOfBirth;
  String? get timeOfBirth => _timeOfBirth;
  String? get locationOfBirth => _locationOfBirth;
  String? get bloodGroup => _bloodGroup;
  String? get sex => _sex;
  String? get height => _height;
  String? get ethnicity => _ethnicity;
  String? get eyeColour => _eyeColour;

  // Setters
  set dateOfBirth(String? value) {
    _dateOfBirth = value;
  }

  set timeOfBirth(String? value) {
    _timeOfBirth = value;
  }

  set locationOfBirth(String? value) {
    _locationOfBirth = value;
  }

  set bloodGroup(String? value) {
    _bloodGroup = value;
  }

  set sex(String? value) {
    _sex = value;
  }

  set height(String? value) {
    _height = value;
  }

  set ethnicity(String? value) {
    _ethnicity = value;
  }

  set eyeColour(String? value) {
    _eyeColour = value;
  }
}
