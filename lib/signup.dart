import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'login.dart'; // Import the LoginPage

class SignupPage extends StatefulWidget {
  const SignupPage({
    super.key,
  });

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmedpasswordController = TextEditingController();
 // bool _isSecurePassword = true ;


@override
void dispose(){
  _nameController.dispose();
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
}


  Future SignupPage() async {
    if  (passwordConfirmed()){
      await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
        email: _emailController.text.trim(), 
        password: _passwordController.text.trim())
      .then ((SignupPage) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const VerifyScreen()));
    } );
  }
}

  Future addUserDetails(
    String name,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection('household user').add({
      'name': name,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    if (_confirmedpasswordController.text.trim() ==
      _confirmedpasswordController.text.trim()) {
        return true;
      } else {
        return false;
      }
    }
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F2F1), Colors.white],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2.0, top: 2.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hi,\nSign Up!",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B553E),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Join OptiFood now. It's free.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Name Field
                      const Text(
                        "Name:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF0B553E),
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 12.0),
                          hintText: 'Enter your name',
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Email Field
                      const Text(
                        "Email:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF0B553E),
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0), // Adjusted padding
                          hintText: 'Enter your email',
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Password Field
                      const Text(
                        "Password:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF0B553E),
                        ),
                      ),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0), // Adjusted padding
                          hintText: 'Enter your password',
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Signup Button
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle signup action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0B553E),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 160, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              children: [
                                TextSpan(
                                  text: "Login",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.black,
                                    decorationThickness: 2.0,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const LoginPage(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 160),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        "By continuing, you agree to OptiFood's",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Terms of Use",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.grey[600],
                                decorationThickness: 2.0,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "and",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 4),
                          RichText(
                            text: TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.grey[600],
                                decorationThickness: 2.0,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
