import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.userExists(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User already exists')),
      );
    } else {
      userProvider.addUser(email, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 700,
          height: 840,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFFE1FF9B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 68,
                top: 0,
                child: SizedBox(
                  width: 563,
                  child: Text(
                    'Welcome to TaskManagerIO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 173,
                child: SizedBox(
                  width: 563,
                  child: Text(
                    'Get started on your tasks, finish todos, and make that project’s progress skyrocket!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
              Positioned(
                left: 12,
                top: -34,
                child: Image.asset(
                  'assets/images/img1.jpg',
                  width: 179,
                  height: 228,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: 509,
                top: -37,
                child: Image.asset(
                  'assets/images/img2.jpg',
                  width: 184,
                  height: 210,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0AD800),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      ),
                      child: Text(
                        'Sign up!',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 68,
                top: 548,
                child: SizedBox(
                  width: 563,
                  child: Text(
                    'Already have an account? Log in below!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
              Positioned(
                left: 29,
                top: 621,
                child: SizedBox(
                  width: 304,
                  child: Text(
                    'This software was developed as part of a project for Mobile Information Systems at FCSE by Damjan Avramovski.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
              Positioned(
                left: 23,
                top: 727,
                child: SizedBox(
                  width: 376,
                  child: Text(
                    'email: damjan.avramovski@students.finki.ukim.mk',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
              Positioned(
                left: 577,
                top: 219,
                child: Image.asset(
                  'assets/images/img5.jpg',
                  width: 123,
                  height: 257,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: 0,
                top: 120,
                child: Image.asset(
                  'assets/images/img4.jpg',
                  width: 137,
                  height: 456,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                right: 40,
                top: 621,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    'Log in!',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
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
