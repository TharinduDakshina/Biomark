import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../providers/volunteer_provider.dart';
import '../theme/app_theme.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (_) => VolunteerProvider(),
      child: SafeArea(
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
                                    labelText: 'Date of Birth',
                                    errorText: provider.dobError,
                                    onChanged: provider.updateDob,
                                    provider: provider,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextFormField(
                                    labelText: 'Time of Birth',
                                    errorText: provider.timeOfBirthError,
                                    onChanged: provider.updateTimeOfBirth,
                                    provider: provider,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextFormField(
                                    labelText: 'Location of Birth',
                                    errorText: provider.locationOfBirthError,
                                    onChanged: provider.updateLocationOfBirth,
                                    provider: provider,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextFormField(
                                    labelText: 'Blood Group',
                                    errorText: provider.bloodGroupError,
                                    onChanged: provider.updateBloodGroup,
                                    provider: provider,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextFormField(
                                    labelText: 'Sex',
                                    errorText: provider.sexError,
                                    onChanged: provider.updateSex,
                                    provider: provider,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextFormField(
                                    labelText: 'Height',
                                    errorText: provider.heightError,
                                    onChanged: provider.updateHeight,
                                    provider: provider,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextFormField(
                                    labelText: 'Ethnicity',
                                    errorText: provider.ethnicityError,
                                    onChanged: provider.updateEthnicity,
                                    provider: provider,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextFormField(
                                    labelText: 'Eye Colour',
                                    errorText: provider.eyeColourError,
                                    onChanged: provider.updateEyeColour,
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
                                  ElevatedButton(
                                    onPressed: () {
                                      provider.validateFields();
                                      if (_formKey.currentState!.validate()) {
                                        if (provider.dobError == null &&
                                            provider.timeOfBirthError == null &&
                                            provider.locationOfBirthError ==
                                                null &&
                                            provider.bloodGroupError == null &&
                                            provider.sexError == null &&
                                            provider.heightError == null &&
                                            provider.ethnicityError == null &&
                                            provider.eyeColourError == null) {
                                          submitData(provider);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      foregroundColor: AppTheme.colors.secondary,
                                      backgroundColor: AppTheme.colors.primary,
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.colors.secondary),
                                    ),
                                    child: const Text('Subscribe'),
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
      ),
    );
  }

  // Method to build styled TextFormFields
  Widget _buildTextFormField({
    required String labelText,
    required String? errorText,
    required Function(String) onChanged,
    required VolunteerProvider provider,
  }) {
    return TextFormField(
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
      print('Date of Birth: ${provider.dob}');
      print('Time of Birth: ${provider.timeOfBirth}');
      print('Location of Birth: ${provider.locationOfBirth}');
      print('Blood Group: ${provider.bloodGroup}');
      print('Sex: ${provider.sex}');
      print('Height: ${provider.height}');
      print('Ethnicity: ${provider.ethnicity}');
      print('Eye Colour: ${provider.eyeColour}');
    }
  }
}
