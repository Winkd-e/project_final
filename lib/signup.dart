import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projects/verify.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();
  final _householdNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    _householdNameController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (passwordConfirmed()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        await addUserDetails(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          _emailController.text.trim(),
          _householdNameController.text.trim(),
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const VerifyScreen(),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
    }
  }

  Future<void> addUserDetails(
    String firstName,
    String lastName,
    String email,
    String householdName,
  ) async {
    await FirebaseFirestore.instance.collection('household_users').add({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'householdName': householdName,
    });
  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmedPasswordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
              const Text(
                'Hi,',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const Text(
                'Sign Up!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B553E),
                ),
              ),
              const Text(
                "Join OptiFood now, it's free.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              _InputField(
                label: 'First Name',
                hintText: 'Juan',
                controller: _firstNameController,
              ),
              const SizedBox(height: 16),
              _InputField(
                label: 'Last Name',
                hintText: 'de la Cruz',
                controller: _lastNameController,
              ),
              const SizedBox(height: 16),
              _InputField(
                label: 'Email',
                hintText: 'juandelacruz@gmail.com',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              _InputField(
                label: 'Password',
                hintText: '••••••',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 16),
              _InputField(
                label: 'Confirm Password',
                hintText: '••••••',
                obscureText: true,
                controller: _confirmedPasswordController,
              ),
              const SizedBox(height: 16),
              _InputField(
                label: 'Household Name',
                hintText: 'Enter your household name',
                controller: _householdNameController,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B553E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(color: Colors.grey[600]),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Color(0xFF0B553E),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SigninPage()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "By continuing, you agree to OptiFood's\n",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    children: [
                      TextSpan(
                        text: 'Terms of Use',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.grey[600],
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          // Navigate to Terms of Use
                        },
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.grey[600],
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          // Navigate to Privacy Policy
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  const _InputField({
    Key? key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}