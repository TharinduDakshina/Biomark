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
  late bool isDataSaved=false;
  var userData;
  String buttonName="Submit";
  late String state="null";
  late BuildContext context2;

  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
      await firestore
          .collection("userInfo")
          .where("userId", isEqualTo: userId)
          .get().then((value) {

        userData = value.docs.first.data();
        isDataSaved = value.docs.first.exists;

      });



      if(isDataSaved){
        setState(() {
          state=userData['state'];
          if(state!="Unsubscribe" && state!="null"){
            buttonName="UnSubscribe";
            _dobController.text = userData['dateOfBirth'] ?? '';
            _timeOfBirthController.text=userData['timeOfBirth'] ?? '';
            _locationOfBirthController.text=userData['locationOfBirth'] ?? '';
            _bloodGroupController.text=userData['bloodGroup'] ?? '';
            _sexController.text=userData['sex'] ?? '';
            _heightController.text=userData['height'] ?? '';
            _ethnicityController.text=userData['ethnicity'] ?? '';
            _eyeColourController.text=userData['eyeColour'] ?? '';
          }
        });
      }else{
        // showToast('User id ${userId}');
      }
    } else {
      setState(() {
        isDataSaved = false;
        userData=null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context2=context;
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
                                  onPressed: () async {
                                    if(isDataSaved && state!="Unsubscribe" && state!="null"){
                                      try{
                                        Map<String, String?> newData() {
                                          return {
                                            'userId':_user?.uid,
                                            'dateOfBirth': _dobController.text.trim(),
                                            'timeOfBirth': _timeOfBirthController.text.trim(),
                                            'locationOfBirth': _locationOfBirthController.text.trim(),
                                            'bloodGroup': _bloodGroupController.text.trim(),
                                            'sex': _sexController.text.trim(),
                                            'height': _heightController.text.trim(),
                                            'ethnicity': _ethnicityController.text.trim(),
                                            'eyeColour': _eyeColourController.text.trim(),
                                            'state': "Unsubscribe",
                                          };
                                        }

                                        QuerySnapshot querySnapshot = await firestore.collection('userInfo')
                                            .where("userId", isEqualTo: _user?.uid)
                                            .get();

                                        for (var doc in querySnapshot.docs) {
                                          await firestore.collection('userInfo')
                                              .doc(doc.id)
                                              .update(newData());
                                        }
                                        showToast('Unsubscribed.');
                                        Navigator.pop(context);
                                        // methanin back wenna danna
                                      }catch(e){
                                        showToast('$e');
                                      }

                                    }else{
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
                                  child: Text(buttonName),
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
          _user!.uid,
          state,
          context2
      );
    }
  }

  checkValidation(String dobController, String value) {
    final dobPattern = RegExp(r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$');
    final timePattern =RegExp(r'^(?:[01]\d|2[0-3]):[0-5]\d$');
    final bloodGroupPattern=RegExp(r'^(A|B|AB|O)[+-]$');
    final genderPattern =RegExp(r'^(male|female|M|F|non-binary|genderqueer|genderfluid|transgender|agender|other)$', caseSensitive: false);
    final heightPattern = RegExp(r'^([5-9][0-9]|1[0-9]{2}|2[0-9]{2}|300)\s?cm$');
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
          _heightError = '150cm 120cm (without space before cm and 50cm-300cm)';
        }
        break;
      case '_ethnicityController':
        _ethnicityError = _ethnicityController.text.isEmpty ? 'Please enter your ethnicity' : null;
        break;
      case '_eyeColourController':
        if(value.isNotEmpty && eyeColorPattern.hasMatch(value)){
          _eyeColourError=null;
        }else{
          _eyeColourError =  'Eye color types are "blue," "brown," "hazel," "gray," and "amber"';
        }
        break;
      default:
        print('fire the default condition');
    }
  }


}