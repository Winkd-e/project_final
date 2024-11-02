import 'package:firebase_auth/firebase_auth.dart';
import 'package:projects/login.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'walkthrough.dart'; // Import the WalkthroughPage

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay before navigating to the WalkthroughPage
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to WalkthroughPage after 5 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WalkthroughPage()),
      );
    });
  }


    

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for authentication state
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png', // Ensure this image path is correct
                  width: 200, // Adjust width if needed
                  height: 200, // Adjust height if needed
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0B553E)),
                ),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          // If a user is authenticated, navigate to the dashboard
          return DashboardPage();
        } else {
          // If no user is logged in, show the main login page
          return SigninPage();
        }
        },
      ),
    );
  }
}
