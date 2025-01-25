import 'package:flutter/material.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 173,
                child: SizedBox(
                  width: 563,
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
              ),
              Positioned(
                left: 60,
                top: 265,
                child: SizedBox(
                  width: 304,
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
              ),
              Positioned(
                left: 384,
                top: 265,
                child: SizedBox(
                  width: 304,
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
                left: 144,
                top: 738,
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
              Positioned(
                left: 0,
                top: 468,
                child: Image.asset(
                  'assets/images/img3.jpg',
                  width: 393,
                  height: 276,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ],
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


