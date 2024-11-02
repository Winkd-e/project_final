import 'package:firstapp/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'signup.dart'; // Import the SignupPage

class WalkthroughPage extends StatefulWidget {
  const WalkthroughPage({super.key});

  @override
  _WalkthroughPageState createState() => _WalkthroughPageState();
}

class _WalkthroughPageState extends State<WalkthroughPage> {
  final PageController _pageController = PageController(viewportFraction: 0.75);
  int _currentPage = 0;

  final List<String> _images = [
    'assets/walk1.png',
    'assets/walk2.png',
    'assets/walk3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Opti',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0B553E),
                      ),
                    ),
                    TextSpan(
                      text: 'Food',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0B553E),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              width: 340,
                              height: 500,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(
                                  color: const Color(0xFF0B553E),
                                  width: 4,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(_images[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _images.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 12,
                            width: _currentPage == index ? 16 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? const Color(0xFF0B553E)
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to the SignupPage when the button is clicked
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0B553E),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              minimumSize: const Size(158, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: 158,
                            child: TextButton(
                              onPressed: () {
                                // Navigate to the LoginPage when the button is clicked
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFFFFFFF),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                side: const BorderSide(
                                  color: Color(0xFF0B553E),
                                  width: 4,
                                ),
                                minimumSize: const Size(158, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF0B553E),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
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
