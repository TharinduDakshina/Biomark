import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  PersonalDetailsScreenState createState() => PersonalDetailsScreenState();
}

class PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  // Controllers for each field
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController mothersMaidenNameController =
      TextEditingController();
  final TextEditingController bestFriendNameController =
      TextEditingController();
  final TextEditingController petsNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          var data = userData.data() as Map<String, dynamic>;

          // print('User data fetched:');
          // print('Full Name: ${data['fullName']}');

          if (data['dateOfBirth'] is Timestamp) {
            Timestamp timestamp = data['dateOfBirth'];
            DateTime dateOfBirth = timestamp.toDate();
            String formattedDate = DateFormat('MM/dd/yyyy').format(dateOfBirth);
            dobController.text = formattedDate;
            // print('Date of Birth: $formattedDate');
          } else {
            dobController.text = data['dateOfBirth'] ?? '';
            // print('Date of Birth: ${data['dateOfBirth']}');
          }

          // print('Mother\'s Maiden Name: ${data['mothersMaidenName']}');
          // print('Best Friend\'s Name: ${data['bestFriendName']}');
          // print('Pet\'s Name: ${data['petName']}');
          // print('City: ${data['cityGrewUp']}');

          fullNameController.text = data['fullName'] ?? '';
          mothersMaidenNameController.text = data['mothersMaidenName'] ?? '';
          bestFriendNameController.text = data['bestFriendName'] ?? '';
          petsNameController.text = data['petName'] ?? '';
          cityController.text = data['cityGrewUp'] ?? '';
        } else {
          if (kDebugMode) {
            print('User document does not exist.');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching user data: $e');
        }
      }
    } else {
      if (kDebugMode) {
        print('No user is currently signed in.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Details',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.colors.primary,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppTheme.colors.primary,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: AppTheme.colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Full Name Field (Read-Only)
              TextFormField(
                controller: fullNameController,
                enabled: false,
                style: TextStyle(
                    color: AppTheme.colors.primary,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                      color: AppTheme.colors.primary,
                      fontWeight: FontWeight.bold),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppTheme.colors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Date of Birth Field (Read-Only)
              TextFormField(
                controller: dobController,
                enabled: false,
                style: TextStyle(
                    color: AppTheme.colors.primary,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  labelStyle: TextStyle(
                      color: AppTheme.colors.primary,
                      fontWeight: FontWeight.bold),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppTheme.colors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Mother's Maiden Name Field (Read-Only)
              TextFormField(
                controller: mothersMaidenNameController, // Assigning controller
                enabled: false,
                style: TextStyle(
                    color: AppTheme.colors.primary,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Mother\'s Maiden Name',
                  labelStyle: TextStyle(
                      color: AppTheme.colors.primary,
                      fontWeight: FontWeight.bold),
                  // Black label text
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppTheme.colors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Childhood Best Friend's Name Field (Read-Only)
              TextFormField(
                controller: bestFriendNameController, // Assigning controller
                enabled: false,
                style: TextStyle(
                    color: AppTheme.colors.primary,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Childhood Best Friend\'s Name',
                  labelStyle: TextStyle(
                      color: AppTheme.colors.primary,
                      fontWeight: FontWeight.bold),
                  // Black label text
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppTheme.colors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Childhood Pet's Name Field (Read-Only)
              TextFormField(
                controller: petsNameController, // Assigning controller
                enabled: false,
                style: TextStyle(
                  color: AppTheme.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Childhood Pet\'s Name',
                  labelStyle: TextStyle(
                      color: AppTheme.colors.primary,
                      fontWeight: FontWeight.bold),
                  // Black label text
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppTheme.colors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // City You Grew Up In Field (Read-Only)
              TextFormField(
                controller: cityController, // Assigning controller
                enabled: false,
                style: TextStyle(
                    color: AppTheme.colors.primary,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'City You Grew Up In',
                  labelStyle: TextStyle(
                      color: AppTheme.colors.primary,
                      fontWeight: FontWeight.bold),
                  // Black label text
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: AppTheme.colors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers when no longer needed to free up resources
    fullNameController.dispose();
    dobController.dispose();
    mothersMaidenNameController.dispose();
    bestFriendNameController.dispose();
    petsNameController.dispose();
    cityController.dispose();
    super.dispose();
  }
}
