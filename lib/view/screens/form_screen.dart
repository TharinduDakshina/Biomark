import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../../controller/formController.dart';
import '../Util/ToastMassage.dart';
import '../providers/volunteer_provider.dart';
import '../theme/app_theme.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  String? temp;
  String? _dobError;
  String? _timeOfBirthError;
  String? _locationOfBirthError;
  String? _bloodGroupError;
  String? _sexError;
  String? _heightError;
  String? _ethnicityError;
  String? _eyeColourError;
  User? _user;
  late bool isDataSaved;
  Map<String, dynamic>? userData;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _timeOfBirthController = TextEditingController();
  final TextEditingController _locationOfBirthController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ethnicityController = TextEditingController();
  final TextEditingController _eyeColourController = TextEditingController();


  @override
  void initState() {
    super.initState();
    checkUserData();
  }

  Future<void> checkUserData() async  {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      String? userId = _user?.uid;


       await FirebaseFirestore.instance
          .collection("userInfo").doc(userId).get().then((value) {
        // login user data collect
         showToast('${value}');
         final data = value.data() as Map<String, dynamic>;

      });

      //  var exists = userDoc.data().toString();
      // isDataSaved = userDoc.exists;
      //
      // showToast('${userDoc.exists}');
      //
      // showToast('${userDoc}');
      // print("========================================================================================= ${userDoc}");

      // if(isDataSaved){
      //   showToast('Data has in database.');
      //   setState(() {
      //     userData = userDoc.data() as Map<String, dynamic>?;
      //     _dobController.text = userData != null && userData!.containsKey('dateOfBirth') ? userData!['dateOfBirth'] : '';
      //     _timeOfBirthController.text=userData!['timeOfBirth'] ?? '';
      //     _locationOfBirthController.text=userData!['locationOfBirth'] ?? '';
      //     _bloodGroupController.text=userData!['bloodGroup'] ?? '';
      //     _sexController.text=userData!['sex'] ?? '';
      //     _heightController.text=userData!['height'] ?? '';
      //     _ethnicityController.text=userData!['ethnicity'] ?? '';
      //     _eyeColourController.text=userData!['eyeColour'] ?? '';
      //
      //     print("=========================================================================================");
      //
      //     print('Date of Birth: ${userData != null && userData!.containsKey('dateOfBirth') ? userData!['dateOfBirth'] : ''}');
      //     print('Time of Birth: ${userData!['timeOfBirth'] ?? ''}');
      //     print('Location of Birth: ${userData!['locationOfBirth'] ?? ''}');
      //     print('Blood Group: ${userData!['bloodGroup'] ?? ''}');
      //     print('Sex: ${userData!['sex'] ?? ''}');
      //     print('Height: ${userData!['height'] ?? ''}');
      //     print('Ethnicity: ${userData!['ethnicity'] ?? ''}');
      //     print('Eye Colour: ${userData!['eyeColour'] ?? ''}');
      //   });
      // }else{
      //   showToast('User id ${userId}');
      //   showToast('${exists}');
      // }
    } else {
      setState(() {
        isDataSaved = false;
        userData=null;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (_) => VolunteerProvider(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.colors.secondary,
          shadowColor: AppTheme.colors.secondary,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppTheme.colors.primary,
              )),
          title: Text(
            'Biomark volunteer',
            style: TextStyle(
              color: AppTheme.colors.primary,
              fontFamily: "Poppins",
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Consumer<VolunteerProvider>(
          builder: (context, provider, child) {
            return Container(
              width: screenWidth,
              decoration: BoxDecoration(color: AppTheme.colors.secondary),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: SizedBox(
                          width: screenWidth,
                          child: ReadMoreText(
                            "We are collecting personal data from volunteers to build advanced predictive machine learning models. The information provided will help us personalize digital services and improve their efficiency in the future. By participating, you contribute to innovations that could lead to significant benefits in various digital domains. Your identity will remain confidential, and as a volunteer, you will be recognized with special benefits through a 'Participator Account' (PAC), ensuring that your contribution is acknowledged in the future advancements of our services.  ",
                            trimLines: 3,
                            textAlign: TextAlign.justify,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: "Read more",
                            trimExpandedText: "Read less",
                            lessStyle: TextStyle(
                                color: AppTheme.colors.primary,
                                fontWeight: FontWeight.bold),
                            moreStyle: TextStyle(
                                color: AppTheme.colors.primary,
                                fontWeight: FontWeight.bold),
                            style: TextStyle(
                              color: AppTheme.colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _buildTextFormField(
                                  controller: _dobController,
                                  labelText: 'Date of Birth',
                                  errorText: _dobError,
                                  onChanged: (value){
                                    setState(() {
                                      checkValidation("_dobController".toString(),value);
                                    });
                                  },
                                  provider: provider,
                                ),
                                const SizedBox(height: 16),
                                _buildTextFormField(
                                  controller: _timeOfBirthController,
                                  labelText: 'Time of Birth',
                                  errorText: _timeOfBirthError,
                                  onChanged: (value){
                                    setState(() {
                                      checkValidation("_timeOfBirthController".toString(),value);
                                    });
                                  },
                                  provider: provider,
                                ),
                                const SizedBox(height: 16),
                                _buildTextFormField(
                                  controller: _locationOfBirthController,
                                  labelText: 'Location of Birth',
                                  errorText: _locationOfBirthError,
                                  onChanged: (value){
                                    setState(() {
                                      checkValidation("_locationOfBirthController".toString(),value);
                                    });
                                  } ,
                                  provider: provider,
                                ),
                                const SizedBox(height: 16),
                                _buildTextFormField(
                                  controller: _bloodGroupController,
                                  labelText: 'Blood Group',
                                  errorText: _bloodGroupError,
                                  onChanged: (value){
                                    setState(() {
                                      checkValidation("_bloodGroupController".toString(),value);
                                    });
                                  },
                                  provider: provider,
                                ),
                                const SizedBox(height: 16),
                                _buildTextFormField(
                                  controller: _sexController,
                                  labelText: 'Sex',
                                  errorText: _sexError,
                                  onChanged: (value){
                                    setState(() {
                                      checkValidation("_sexController".toString(),value);
                                    });
                                  },
                                  provider: provider,
                                ),
                                const SizedBox(height: 16),
                                _buildTextFormField(
                                  controller: _heightController,
                                  labelText: 'Height',
                                  errorText: _heightError,
                                  onChanged: (value){
                                    setState(() {
                                      checkValidation("_heightController".toString(),value);
                                    });
                                  },
                                  provider: provider,
                                ),
                                const SizedBox(height: 16),
                                _buildTextFormField(
                                  controller: _ethnicityController,
                                  labelText: 'Ethnicity',
                                  errorText: _ethnicityError,
                                  onChanged: (value){
                                    setState(() {
                                      checkValidation("_ethnicityController".toString(),value);
                                    });
                                  } ,
                                  provider: provider,
                                ),
                                const SizedBox(height: 16),
                                _buildTextFormField(
                                  controller: _eyeColourController,
                                  labelText: 'Eye Colour',
                                  errorText: _eyeColourError,
                                  onChanged: (value){
                                    setState(() {
                                      checkValidation("_eyeColourController".toString(),value);
                                    });
                                  },
                                  provider: provider,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.topCenter,
                                      height: 40,
                                      child: Text(
                                        "Note: ",
                                        style: TextStyle(
                                            color: AppTheme.colors.red),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.topCenter,
                                      height: 40,
                                      child: Text(
                                        "You can unsubscribe from this service any anytime. ",
                                        style: TextStyle(
                                            color: AppTheme.colors.red
                                                .withOpacity(0.7)),
                                      ),
                                    ))
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () {

                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        provider.validateFields();
                                      });

                                      if (provider.dobError == null &&
                                          provider.timeOfBirthError == null &&
                                          provider.locationOfBirthError == null &&
                                          provider.bloodGroupError == null &&
                                          provider.sexError == null &&
                                          provider.heightError == null &&
                                          provider.ethnicityError == null &&
                                          provider.eyeColourError == null) {
                                      }else{
                                        submitData(provider);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    foregroundColor: AppTheme.colors.secondary,
                                    backgroundColor: AppTheme.colors.primary,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  child: const Text('Submit'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Method to build styled TextFormFields
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String? errorText,
    required Function(String) onChanged,
    required VolunteerProvider provider,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: AppTheme.colors.primary),
        hintStyle: TextStyle(
          color: AppTheme.colors.primary.withOpacity(0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: AppTheme.colors.light,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: AppTheme.colors.primary,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: AppTheme.colors.black,
            width: 1,
          ),
        ),
        errorText: errorText,
      ),
    );
  }

  void submitData(VolunteerProvider provider) {
    if (kDebugMode) {
      saveUserData(
          _dobController.text.trim(),
          _timeOfBirthController.text.trim(),
          _locationOfBirthController.text.trim(),
          _bloodGroupController.text.trim(),
          _sexController.text.trim(),
          _heightController.text.trim(),
          _ethnicityController.text.trim(),
          _eyeColourController.text.trim(),
          _user!.uid
      );
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
          _dobError =  'Should be DD/MM/YYYY';
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
