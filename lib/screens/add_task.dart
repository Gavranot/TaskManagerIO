import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_io/models/user.dart';
import 'package:task_manager_io/screens/home_screen.dart';
import '../providers/user_provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  final _priorityController = TextEditingController(text: '2.0');
  DateTime? _selectedDeadline;

  void _submitTask() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final taskName = _taskNameController.text;
    final taskDescription = _taskDescriptionController.text;
    final taskPriority = double.tryParse(_priorityController.text) ?? 0.0;

    if (taskName.isEmpty || taskDescription.isEmpty || _selectedDeadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields and select a deadline')),
      );
      return;
    }

    userProvider.loggedInUser?.tasks.add(
      Task(
        name: taskName,
        description: taskDescription,
        priority: taskPriority,
        deadline: _selectedDeadline,
        done: false,
      ),
    );

    // Clear inputs after submission
    _taskNameController.clear();
    _taskDescriptionController.clear();
    _priorityController.text = '2.0';
    setState(() {
      _selectedDeadline = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task added successfully')),
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
          (Route<dynamic> route) => false,
    );
  }

  void _pickDeadline() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDeadline = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1FF9B),
      appBar: AppBar(title: const Text('Add Task')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
                children: [
                  // Top-left image
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/img1.jpg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(child:  // Top-right image
                      Image.asset(
                        'assets/images/img2.jpg',
                        fit: BoxFit.contain,
                      ),)
                    ],
                  ),
                  TextField(
                    controller: _taskNameController,
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _taskDescriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Task Description',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Task Priority',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: _priorityController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.calendar_today, size: 40),
                        iconAlignment: IconAlignment.end,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00FF2E),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: _pickDeadline,
                        label: Text(
                          _selectedDeadline == null
                              ? 'Set a deadline'
                              : '${_selectedDeadline!.day}/${_selectedDeadline!.month}/${_selectedDeadline!.year}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
        
                    ],
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FFFF),
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: _submitTask,
                    child: const Text(
                      'Add task',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        ),
      ),);

  }
}
