import 'package:biomark/view/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/birthday_provider.dart';
import '../theme/app_theme.dart';

class RecoveryScreen1 extends StatefulWidget {
  const RecoveryScreen1({super.key});

  @override
  State<RecoveryScreen1> createState() => _RecoveryScreen1State();
}

class _RecoveryScreen1State extends State<RecoveryScreen1> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _fullNameController = TextEditingController();
  final _mothersMaidenNameController = TextEditingController();
  final _cityGrewUpController = TextEditingController();
  DateTime? dateOfBirth; // Nullable to handle validation


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(color: AppTheme.colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Account Recovery",
                      style: TextStyle(
                        color: AppTheme.colors.primary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Please provide below details to recover your account.",
                          style: TextStyle(color: AppTheme.colors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.1,
                        right: screenWidth * 0.1,
                        top: 5,
                      ),
                      child: Column(
                        children: [
                          // Full Name
                          _buildTextField('Full Name', _fullNameController),
                          const SizedBox(height: 10),
                          // Date of Birth
                          _buildDateOfBirthField(context),
                          const SizedBox(height: 10),
                          // Mother's Maiden Name
                          _buildTextField("Mother's Maiden Name", _mothersMaidenNameController),
                          const SizedBox(height: 10),
                          // City You Grew Up
                          _buildTextField('City You Grew Up', _cityGrewUpController),
                          const SizedBox(height: 15),
                          SubmitButton(
                            onPressed: _onSubmit, // Modified to call function directly
                            buttonColor: AppTheme.colors.primary,
                            textColor: AppTheme.colors.secondary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.colors.primary,
          ),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            hintStyle: TextStyle(color: AppTheme.colors.primary.withOpacity(0.5)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppTheme.colors.light, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppTheme.colors.black, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: AppTheme.colors.black, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateOfBirthField(BuildContext context) {
    return Consumer<BirthdayProvider>(
      builder: (context, birthdayProvider, child) {
        return GestureDetector(
          onTap: () => _selectedDate(context, birthdayProvider),
          child: AbsorbPointer(
            child: TextFormField(
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: AppTheme.colors.primary.withOpacity(0.5),
                  fontWeight: FontWeight.bold
                ),
                labelText: birthdayProvider.selectedDate != null
                    ? birthdayProvider.getFormattedDate()
                    : 'Date of Birth',
                hintText: birthdayProvider.selectedDate != null
                    ? birthdayProvider.getFormattedDate()
                    : 'Select Date of Birth',
                suffixIcon: const Icon(Icons.calendar_month_sharp),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: AppTheme.colors.light, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: AppTheme.colors.black, width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: AppTheme.colors.black, width: 1),
                ),
              ),
              readOnly: true, // Make it read-only
            ),
          ),
        );
      },
    );
  }


  Future<void> _selectedDate(BuildContext context, BirthdayProvider provider) async {
    DateTime? birthDay = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (birthDay != null) {
      provider.setSelectedDate(birthDay);
      dateOfBirth = birthDay; // Update the dateOfBirth variable
    }
  }

  Future<void> _onSubmit() async {
    String fullName = _fullNameController.text.trim();
    String motherMaidenName = _mothersMaidenNameController.text.trim();
    String cityGrewUp = _cityGrewUpController.text.trim();

    // Validate inputs
    if (fullName.isEmpty || dateOfBirth == null || motherMaidenName.isEmpty || cityGrewUp.isEmpty) {
      _showSnackBar("Please fill in all fields.");
      return;
    }

    try {

      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .where('fullName', isEqualTo: fullName)
          .where('dateOfBirth', isEqualTo: dateOfBirth)
          .where('mothersMaidenName', isEqualTo: motherMaidenName)
          .where('cityGrewUp', isEqualTo: cityGrewUp)
          .get();


      if (query.docs.isNotEmpty) {

        var data = query.docs.first.data() as Map<String, dynamic>;
        // print("Document data: $data");
        if (data.containsKey('email') && data['email'] != null) {
          String userEmail = data['email'] as String;


          // print("User email: $userEmail");


          Navigator.pushNamed(
            context,
            '/recoveryscreen2',
            arguments: userEmail,
          );
        } else {
          print("Email field is missing or null.");
        }
      } else {
        _showSnackBar("No matching user found. Please check your information.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
      _showSnackBar("An error occurred: $e");
    }

  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
