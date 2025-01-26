import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import 'edit_task.dart';
import 'home_screen.dart';

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  State createState() => _TaskDetailsScreenState();
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

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Task details'),
          actions: [
            IconButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTask(task: task),
                        ),
                      )
                    },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () => _deleteTask.call(), icon: Icon(Icons.delete))
          ],
        ),
        backgroundColor: Color(0xFFE1FF9B),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left and Right Images
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/img1.jpg',
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                Text(
                  'Task name:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withAlpha(150),
                    fontSize: 18,
                    fontFamily: 'Jua',
                  ),
                ),
                Text(
                  task.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Task description:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withAlpha(150),
                    fontSize: 18,
                    fontFamily: 'Jua',
                  ),
                ),
                Text(
                  task.description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Task priority:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withAlpha(150),
                    fontSize: 18,
                    fontFamily: 'Jua',
                  ),
                ),
                Text(
                  task.priority.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Deadline:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withAlpha(150),
                    fontSize: 18,
                    fontFamily: 'Jua',
                  ),
                ),
                Text(
                  task.deadline?.toString() ?? "No deadline set",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        task.done = true;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                              (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        backgroundColor: Color(0xFF00FFFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Mark as done',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
