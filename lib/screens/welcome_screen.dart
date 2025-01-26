import 'package:flutter/material.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE1FF9B),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Welcome to TaskManagerIO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Welcome to TaskManagerIO – Your Developer-Focused Task Management Solution',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                          //decoration: TextDecoration.underline,
                        ),
                        softWrap: true,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/img1.jpg',
                            height: 120,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Image.asset(
                            'assets/images/img2.jpg',
                            height: 120,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "TaskManagerIO is designed with developers and tech professionals in mind—streamline your workflow, stay organized, and focus on what truly matters. Whether you're managing sprints, tracking personal to-dos, or prioritizing work-life balance, TaskManagerIO provides a clean and intuitive interface with powerful features to boost your productivity.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                        ),
                        softWrap: true,
                      ),
                    ),
                    Image.asset(
                      'assets/images/img3.jpg',
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Effortless Task Tracking: Categorize tasks by project or priority with ease.\n'
                            'Smart Prioritization: Stay on top of your goals with custom tags and due dates.\n'
                            'Minimalist UI, Maximum Efficiency: A distraction-free environment to optimize your focus.\n'
                            'Developer-Friendly: Built with performance in mind, ensuring a smooth experience.\n'
                            'Dark Mode Ready: Because your eyes deserve it.',
                        style: TextStyle(
                          color: Color(0xFF0AD800),
                          fontSize: 18,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Container(
                  width: 416,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0AD800),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Get Started Now!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.10,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              color: Color(0xFF0AD800),
              fontSize: 18,
              fontFamily: 'Jua',
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF0AD800),
                fontSize: 18,
                fontFamily: 'Jua',
                fontWeight: FontWeight.w400,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
