import 'package:flutter/material.dart';

class SecurityDetailsPage extends StatelessWidget {
  const SecurityDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Security Details',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24.0), // Add some spacing after the AppBar
            // Email Field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black), // Black label text
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border when focused
                ),
              ),
            ),
            const SizedBox(height: 16.0), // Space between fields
            // Password Field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black), // Black label text
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Black border when focused
                ),
              ),
              obscureText: true, // To hide the password
            ),
            const SizedBox(height: 24.0), // Space between field and button
            // Edit Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle edit action here
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Black text color
                  backgroundColor: Colors.black, // White button background
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Edit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
