import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State createState() => _RegisterScreenState();
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
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
            (Route<dynamic> route) => false,
      );
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      backgroundColor: Color(0xFFE1FF9B),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/img1.jpg',
                height: 200,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 8),
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
              SizedBox(height: 32),
              Text(
                'Already have an account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                ),
                softWrap: true,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    color: Colors.green,
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
