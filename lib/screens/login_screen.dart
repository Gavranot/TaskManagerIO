import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_io/screens/register_screen.dart';
import '../providers/user_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    bool success = userProvider.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful!')),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log In')),
      backgroundColor: Color(0xFFE1FF9B),
      // Background color to match Figma design
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              Image.asset(
                'assets/images/img2.jpg',
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
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0AD800),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
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
              SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        'Register!',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        print("Report an issue clicked");
                      },
                      child: Text(
                        'Report an issue!',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Don’t have an account or need some support?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                ),
                softWrap: true,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Contact us!',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                'This software was developed as part of a project for Mobile Information Systems at FCSE by Damjan Avramovski.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                ),
                softWrap: true,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'damjan.avramovski@students.finki.ukim.mk',
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
