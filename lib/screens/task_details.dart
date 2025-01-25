import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import 'edit_task.dart';
import 'home_screen.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;
  TaskDetailsScreen({required this.task});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {

  /// Remove the current task from the logged in user's task list
  void _deleteTask() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Remove this task from the user's task list
    userProvider.loggedInUser?.tasks.remove(widget.task);

    // Show a confirmation and navigate back or wherever you want
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task deleted!')),
    );

    // Pop the TaskDetailsScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Column(
      children: [
        Container(
          width: 700,
          height: 840,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFFE1FF9B), // Light green background
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Stack(
            children: [
              // Title with improved color
              Positioned(
                left: 68,
                top: 0,
                child: SizedBox(
                  width: 563,
                  child: Text(
                    'Task details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              // Left and Right Images
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
                left: 244,
                top: 100,
                child: Container(
                  width: 212,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xFF00FF2E), // Bright green
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Task name',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 180,
                child: Container(
                  width: 580,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      task.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 244,
                top: 250,
                child: Container(
                  width: 212,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xFF00FF2E), // Bright green
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Task description',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 330,
                child: Container(
                  width: 580,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    task.description ?? 'No description provided',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 450,
                child: Row(
                  children: [
                    Container(
                      width: 212,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF00FF2E), // Bright green
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Task priority',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Jua',
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF0000), // Red
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          task.priority.toString(),
                          style: TextStyle(
                            fontSize: 24,
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
              Positioned(
                left: 60,
                top: 540,
                child: Row(
                  children: [
                    Container(
                      width: 212,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF00FF2E), // Bright green
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Deadline',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Jua',
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF0000), // Red
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          task.deadline?.toString() ?? 'No deadline set',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Jua',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 60,
                top: 650,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      'Edit',
                      Color(0xFF00FFFF),
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTask(task: task),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 20),
                    _buildActionButton(
                      'Delete',
                      Color(0xFF00FFFF),
                      _deleteTask, // Use the new method here
                    ),
                    SizedBox(width: 20),
                    _buildActionButton(
                      'Mark as done',
                      Color(0xFF00FFFF),
                          () {
                        task.done = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Marked as done')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return Container(
      width: 170,
      height: 70,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Jua',
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
