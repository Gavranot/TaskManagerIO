import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_io/models/user.dart';
import 'package:task_manager_io/screens/home_screen.dart';
import '../providers/user_provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
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

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
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
      appBar: AppBar(title: const Text('Add Task')),
      body: SingleChildScrollView(
        child: Center(
          // Constrain to 700x840 just like your design
          child: Container(
            width: 700,
            height: 840,
            padding: const EdgeInsets.all(20),
            decoration: ShapeDecoration(
              color: const Color(0xFFE1FF9B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            // Use a Stack so we can put images above the title
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                final w = constraints.maxWidth;
                final h = constraints.maxHeight;
                return Stack(
                  children: [
                    // Top-left image
                    Positioned(
                      left: w * 0.02,    // tweak as needed
                      top: h * -0.0001,   // negative to “hang” above the container
                      width: w * 0.25,  // scale so it fits
                      child: Image.asset(
                        'assets/images/img1.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Top-right image
                    Positioned(
                      right: w * 0.02,
                      top: h * -0.0001,
                      width: w * 0.25,
                      child: Image.asset(
                        'assets/images/img2.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Everything else (title, text fields, etc.) in a column
                    // Center it inside the container so images stay "above" the title.
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          const Text(
                            'Add task',
                            style: TextStyle(
                              fontSize: 50,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 30),
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
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00FF2E),
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: _pickDeadline,
                                child: Text(
                                  _selectedDeadline == null
                                      ? 'Set a deadline'
                                      : '${_selectedDeadline!.day}/${_selectedDeadline!.month}/${_selectedDeadline!.year}',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              const Icon(Icons.calendar_today, size: 40),
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
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
