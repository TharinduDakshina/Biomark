import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:biomark/view/providers/birthday_provider.dart';



class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _timeOfBirthController = TextEditingController();
  final TextEditingController _locationOfBirthController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ethnicityController = TextEditingController();
  final TextEditingController _eyeColourController = TextEditingController();



  // Error messages for each field
  String? _dobError;
  String? _timeOfBirthError;
  String? _locationOfBirthError;
  String? _bloodGroupError;
  String? _sexError;
  String? _heightError;
  String? _ethnicityError;
  String? _eyeColourError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Biomark',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _dobController,
                  onChanged:(value){
                    setState(() {
                      checkValidation("_dobController".toString(),value);
                    });
                  } ,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    border: const OutlineInputBorder(),
                    errorText: _dobError, // Display error message if any
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _timeOfBirthController,
                  onChanged:(value){
                    setState(() {
                      checkValidation("_timeOfBirthController".toString(),value);
                    });
                  } ,
                  decoration: InputDecoration(
                    labelText: 'Time of Birth',
                    border: const OutlineInputBorder(),
                    errorText: _timeOfBirthError, // Display error message if any
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationOfBirthController,
                  onChanged:(value){
                    setState(() {
                      checkValidation("_locationOfBirthController".toString(),value);
                    });
                  } ,
                  decoration: InputDecoration(
                    labelText: 'Location of Birth',
                    border: const OutlineInputBorder(),
                    errorText: _locationOfBirthError, // Display error message if any
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bloodGroupController,
                  onChanged:(value){
                    setState(() {
                      checkValidation("_bloodGroupController".toString(),value);
                    });
                  } ,
                  decoration: InputDecoration(
                    labelText: 'Blood Group',
                    border: const OutlineInputBorder(),
                    errorText: _bloodGroupError, // Display error message if any
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _sexController,
                  onChanged:(value){
                    setState(() {
                      checkValidation("_sexController".toString(),value);
                    });
                  } ,
                  decoration: InputDecoration(
                    labelText: 'Sex',
                    border: const OutlineInputBorder(),
                    errorText: _sexError, // Display error message if any
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _heightController,
                  onChanged:(value){
                    setState(() {
                      checkValidation("_heightController".toString(),value);
                    });
                  } ,
                  decoration: InputDecoration(
                    labelText: 'Height',
                    border: const OutlineInputBorder(),
                    errorText: _heightError, // Display error message if any
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ethnicityController,
                  onChanged:(value){
                    setState(() {
                      checkValidation("_ethnicityController".toString(),value);
                    });
                  } ,
                  decoration: InputDecoration(
                    labelText: 'Ethnicity',
                    border: const OutlineInputBorder(),
                    errorText: _ethnicityError, // Display error message if any
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _eyeColourController,
                  onChanged:(value){
                    setState(() {
                      checkValidation("_eyeColourController".toString(),value);
                    });
                  } ,
                  decoration: InputDecoration(
                    labelText: 'Eye Colour',
                    border: const OutlineInputBorder(),
                    errorText: _eyeColourError, // Display error message if any
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _validateFields(); // Validate fields and set error messages
                      });

                      // If no error messages, process the form data
                      if (_dobError == null &&
                          _timeOfBirthError == null &&
                          _locationOfBirthError == null &&
                          _bloodGroupError == null &&
                          _sexError == null &&
                          _heightError == null &&
                          _ethnicityError == null &&
                          _eyeColourError == null) {
                        submitData();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.black, // Text color
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white// Bold font weight
                    ),
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectedDate(
      BuildContext context, BirthdayProvider provider) async {
    DateTime? birthDay = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (birthDay != null) {
      provider.setSelectedDate(birthDay);
    }
  }

  void _validateFields() {
    setState(() {
      // Set error messages based on field content
      _dobError = _dobController.text.isEmpty ? 'Please enter your date of birth' : null;
      _timeOfBirthError = _timeOfBirthController.text.isEmpty ? 'Please enter your time of birth' : null;
      _locationOfBirthError = _locationOfBirthController.text.isEmpty ? 'Please enter your location of birth' : null;
      _bloodGroupError = _bloodGroupController.text.isEmpty ? 'Please enter your blood group' : null;
      _sexError = _sexController.text.isEmpty ? 'Please enter your sex' : null;
      _heightError = _heightController.text.isEmpty ? 'Please enter your height' : null;
      _ethnicityError = _ethnicityController.text.isEmpty ? 'Please enter your ethnicity' : null;
      _eyeColourError = _eyeColourController.text.isEmpty ? 'Please enter your eye colour' : null;
    });
  }

  @override
  void dispose() {
    _dobController.dispose();
    _timeOfBirthController.dispose();
    _locationOfBirthController.dispose();
    _bloodGroupController.dispose();
    _sexController.dispose();
    _heightController.dispose();
    _ethnicityController.dispose();
    _eyeColourController.dispose();
    super.dispose();
  }

  void submitData() {
    if (kDebugMode) {
      print('Date of Birth: ${_dobController.text.trim()}');
      print('Time of Birth: ${_timeOfBirthController.text.trim()}');
      print('Location of Birth: ${_locationOfBirthController.text.trim()}');
      print('Blood Group: ${_bloodGroupController.text.trim()}');
      print('Sex: ${_sexController.text.trim()}');
      print('Height: ${_heightController.text.trim()}');
      print('Ethnicity: ${_ethnicityController.text.trim()}');
      print('Eye Colour: ${_eyeColourController.text.trim()}');
    }
  }

  checkValidation(String dobController, String value) {
    final dobPattern = RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$');
    final timePattern =RegExp(r'^(?:[01]\d|2[0-3]):[0-5]\d$');
    final bloodGroupPattern=RegExp(r'^(A|B|AB|O)[+-]$');
    final genderPattern =RegExp(r'^(male|female|M|F|non-binary|genderqueer|genderfluid|transgender|agender|other)$', caseSensitive: false);
    final heightPattern = RegExp(r'^(1[5-9][0-9]|[1-9]?[0-9]|[4-7]"[0-9]|[0-9]")$');
    final eyeColorPattern = RegExp(r'^(blue|brown|green|hazel|gray|amber|violet)$', caseSensitive: false);

    switch (dobController) {
      case "_dobController":
        if(value.isNotEmpty && dobPattern.hasMatch(value)){
          _dobError=null;
        }else{
          _dobError =  'Should be MM/DD/YYYY';
        }
        break;
      case '_timeOfBirthController':
        if(value.isNotEmpty && timePattern.hasMatch(value)){
          _timeOfBirthError=null;
        }else{
          _timeOfBirthError =  'HH:mm (24-hour clock format)';
        }
        break;
      case '_locationOfBirthController':
        _locationOfBirthError = _locationOfBirthController.text.isEmpty ? 'Please enter your location of birth' : null;
        break;
      case '_bloodGroupController':
        if(value.isNotEmpty && bloodGroupPattern.hasMatch(value)){
          _bloodGroupError=null;
        }else{
          _bloodGroupError =  "['A+', 'B-', 'AB+', 'O-', 'C+', 'A', 'B++']";
        }
        break;
      case '_sexController':
        if(value.isNotEmpty && genderPattern.hasMatch(value)){
          _sexError=null;
        }else{
          _sexError =  'Sex types are Male or Female';
        }
        break;
      case '_heightController':
        if(value.isNotEmpty && heightPattern.hasMatch(value)){
          _heightError=null;
        }else{
          _heightError = '(E.G., 170cm, 180cm, 5\'10",4\'10")';
        }
        break;
      case '_ethnicityController':
        _ethnicityError = _ethnicityController.text.isEmpty ? 'Please enter your ethnicity' : null;
        break;
      case '_eyeColourController':
        if(value.isNotEmpty && eyeColorPattern.hasMatch(value)){
          _eyeColourError=null;
        }else{
          _eyeColourError =  'Eye color types are "blue," "brown," "green," "hazel," "gray," and "amber"';
        }
        break;
      default:
        print('fire the default condition');
    }
  }
}



