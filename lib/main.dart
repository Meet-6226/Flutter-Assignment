import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
        ),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 230,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF6C63FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: const Column(
              children: [
                SizedBox(height: 60),
                Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 35,
                ),
                SizedBox(height: 10),
                Text(
                  'PROFILE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          Transform.translate(
            offset: const Offset(0, -65),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 58,
                    backgroundColor: Color(0xFFE8E7FF),
                    child: Icon(
                      Icons.person,
                      size: 65,
                      color: Color(0xFF6C63FF),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Meet Alshi',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Flutter Developer',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '12',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C63FF),
                            ),
                          ),
                          Text('Projects'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '8',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C63FF),
                            ),
                          ),
                          Text('Skills'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '2',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C63FF),
                            ),
                          ),
                          Text('Years'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEBFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: Color(0xFF6C63FF),
                          ),
                          SizedBox(width: 15),
                          Text('meet@example.com'),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF6C63FF),
                          ),
                          SizedBox(width: 15),
                          Text('Mumbai, India'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}