import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projects/dashboard.dart';
import 'package:projects/signup.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
    final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSecurePassword = true;

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (email!.isEmpty) {
      return "Enter Email";
    } else if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  final formKey = GlobalKey<FormState>();
  Future signIn(BuildContext context, String text, String S) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
            .then((signIn) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const DashboardPage()));
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    //welcome text
                    const Text(
                      "Hello,\nWelcome Back!",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B553E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Login to continue your journey with OptiFood.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                   
                   //email text field
                    const Text(
                      "Email or Username:",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF0B553E),
                      ),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your email or username',
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    //password textfield
                    const Text(
                      "Password:",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF0B553E),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: _isSecurePassword,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '6 characters or more',
                      ),
                    ),
                    const SizedBox(height: 16),

                    //login button
                    ElevatedButton(
                        onPressed: () {
                          if (_emailController.text.isNotEmpty && _passwordController.text.length > 6) {
                            signIn(context, _emailController.text, _passwordController.text);
                          } else {
                            debugPrint('LOG: Email is empty or password is invalid');
                          }
                        },
                        child: const Text('Login'),
                      ),

                    
                    //register/signup 
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          children: [
                            TextSpan(
                              text: "Signup",
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
                                      builder: (context) => const SignupPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 220),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "By continuing, you agree to OptiFood's ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
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
    );
  }
}