import 'package:flutter/material.dart';
import 'package:task_manager_io/providers/user_provider.dart';
import 'screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_)=>UserProvider()),
    ],
    child: TaskManagerIOApp(),
  ),
  );

}

class TaskManagerIOApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskManagerIO',
      theme: ThemeData(
        fontFamily: 'Jua',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}
