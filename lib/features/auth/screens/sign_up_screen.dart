import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Network selection state removed for now

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        iconTheme: const IconThemeData(color: Colors.black)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Profile", 
              style: TextStyle(
                fontSize: 32, 
                fontWeight: FontWeight.bold, 
                color: Color(0xFF2563EB)
              )
            ),
            const SizedBox(height: 8),
            Text(
              "Join Temamu and start paying together.", 
              style: TextStyle(color: Colors.grey[600])
            ),
            const SizedBox(height: 32),

            // Full Name Input
            const TextField(
              decoration: InputDecoration(
                labelText: "Full Name", 
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder()
              )
            ),
            const SizedBox(height: 20),

            // Phone Number Input
            const TextField(
              decoration: InputDecoration(
                labelText: "Phone Number", 
                prefixIcon: Icon(Icons.phone_iphone),
                border: OutlineInputBorder()
              ),
              keyboardType: TextInputType.phone,
            ),
            
            const SizedBox(height: 40),

            // SIGN UP BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Later: Save user and go to Home
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
                child: const Text(
                  "Create Account", 
                  style: TextStyle(color: Colors.white, fontSize: 18)
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // NAVIGATION BACK TO LOGIN
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Already have an account? Sign In"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}