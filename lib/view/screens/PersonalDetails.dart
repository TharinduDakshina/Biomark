import 'package:flutter/material.dart';

class PasswordDetailsPage extends StatefulWidget {
  const PasswordDetailsPage({super.key});

  @override
  _PasswordDetailsPageState createState() => _PasswordDetailsPageState();
}

class _PasswordDetailsPageState extends State<PasswordDetailsPage> {
  // Controllers for each field
  final TextEditingController fullNameController = TextEditingController(text: "John Doe");
  final TextEditingController dobController = TextEditingController(text: "01/01/1990");
  final TextEditingController mothersMaidenNameController = TextEditingController(text: "Jane Smith");
  final TextEditingController bestFriendNameController = TextEditingController(text: "Michael Johnson");
  final TextEditingController petsNameController = TextEditingController(text: "Buddy");
  final TextEditingController cityController = TextEditingController(text: "New York");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Password Details',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black, // White text color
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // White icon color
          onPressed: () {
            Navigator.pop(context); // Handle back navigation
          },
        ),
        backgroundColor: Colors.white, // Black app bar background
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Full Name Field (Read-Only)
            TextFormField(
              controller: fullNameController, // Assigning controller
              enabled: false, // Set to false to make the field read-only
              decoration: const InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(color: Colors.black), // Black label text
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border when focused
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Date of Birth Field (Read-Only)
            TextFormField(
              controller: dobController, // Assigning controller
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                labelStyle: TextStyle(color: Colors.black), // Black label text
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border when focused
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Mother's Maiden Name Field (Read-Only)
            TextFormField(
              controller: mothersMaidenNameController, // Assigning controller
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Mother\'s Maiden Name',
                labelStyle: TextStyle(color: Colors.black), // Black label text
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border when focused
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Childhood Best Friend's Name Field (Read-Only)
            TextFormField(
              controller: bestFriendNameController, // Assigning controller
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Childhood Best Friend\'s Name',
                labelStyle: TextStyle(color: Colors.black), // Black label text
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border when focused
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Childhood Pet's Name Field (Read-Only)
            TextFormField(
              controller: petsNameController, // Assigning controller
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Childhood Pet\'s Name',
                labelStyle: TextStyle(color: Colors.black), // Black label text
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border when focused
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // City You Grew Up In Field (Read-Only)
            TextFormField(
              controller: cityController, // Assigning controller
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'City You Grew Up In',
                labelStyle: TextStyle(color: Colors.black), // Black label text
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border when focused
                ),
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                // Handle edit action
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // Black text color
                backgroundColor: Colors.black, // White button background
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Edit Details'),
            ),
          ],
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
