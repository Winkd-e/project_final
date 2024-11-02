import 'package:projects/grocerylistpage.dart';
import 'package:projects/inventorypage.dart';
import 'package:projects/login.dart';
import 'package:projects/mealplannerpage.dart';
import 'package:flutter/material.dart';
import 'notifications.dart'; // Make sure to import the NotificationsPage

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPage createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  bool _isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isDrawerOpen = !_isDrawerOpen; // Toggle profile drawer
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Text(
                'Dan Joseph Bonao',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B553E),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFF0B553E)),
            onPressed: () {
              // Navigate to the NotificationsPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsPage()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: 'Search...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Summary',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF0B553E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'More',
                          style: TextStyle(
                            color: Color(0xFF0B553E),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 130,
                      width: double.infinity,
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          'Wala pa',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Expiring Soon',
                      style: TextStyle(
                        color: Color(0xFF0B553E),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text('Product',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text('Ano lagay dito',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text('Quantity',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text('Eat By',
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ...List.generate(4, (index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: Colors.grey.withOpacity(0.5)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(4, (colIndex) {
                            return Expanded(
                              child: Container(
                                height: 67,
                                color: Colors.white,
                                alignment: Alignment.center,
                                child: Text('R${index + 1}C${colIndex + 1}',
                                    style: const TextStyle(fontSize: 16)),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See more...',
                      style: TextStyle(
                        color: Color(0xFF0B553E),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_isDrawerOpen)
            GestureDetector(
              onTap: () {
                setState(() {
                  _isDrawerOpen = false;
                });
              },
              child: Container(
                color: Colors.black54,
              ),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: _isDrawerOpen ? 0 : -300,
            top: 0,
            height: MediaQuery.of(context).size.height, // Cover full height
            child: Container(
              width: 300,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/profile_menu.png',
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Dan Joseph',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B553E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Stephen Bakes',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Menu',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B553E),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text('Home'),
                          onTap: () {
                            // Refresh DashboardPage
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DashboardPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text('Notifications'),
                          onTap: () {
                            // Navigate to the NotificationsPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NotificationsPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Sign out'),
                          onTap: () {
                            // Perform sign out action
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const SigninPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
