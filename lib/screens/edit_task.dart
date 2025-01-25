import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_io/models/user.dart';
import 'package:task_manager_io/screens/home_screen.dart';
import '../providers/user_provider.dart';

class EditTask extends StatefulWidget {
  final Task task;

  const EditTask({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController _taskNameController;
  late TextEditingController _taskDescriptionController;
  late TextEditingController _priorityController;
  DateTime? _selectedDeadline;

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController(text: widget.task.name);
    _taskDescriptionController = TextEditingController(text: widget.task.description);
    _priorityController = TextEditingController(text: widget.task.priority.toString());
    _selectedDeadline = widget.task.deadline;
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  void _updateTask() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final taskName = _taskNameController.text;
    final taskDescription = _taskDescriptionController.text;
    final taskPriority = double.tryParse(_priorityController.text) ?? 0.0;

    if (taskName.isEmpty ||
        taskDescription.isEmpty ||
        _selectedDeadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields and select a deadline'),
        ),
      );
      return;
    }

    // Update the existing task object
    widget.task.name = taskName;
    widget.task.description = taskDescription;
    widget.task.priority = taskPriority;
    widget.task.deadline = _selectedDeadline;

    // Optionally, you might trigger some provider method to update the
    // data in the backend or local storage, if that’s how your app is structured.
    // For example:
    // userProvider.updateTask(widget.task);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task updated successfully')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void _pickDeadline() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDeadline ?? DateTime.now(),
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
      appBar: AppBar(title: Text('Edit Task')),
      body: Center(
        child: Container(
          width: 700,
          height: 840,
          padding: EdgeInsets.all(20),
          decoration: ShapeDecoration(
            color: Color(0xFFE1FF9B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Editing task',
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 30),
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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Task Priority',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 80,
                    child: TextField(
                      controller: _priorityController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00FF2E),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: _pickDeadline,
                    child: Text(
                      _selectedDeadline == null
                          ? 'Set a deadline'
                          : '${_selectedDeadline!.day}/${_selectedDeadline!.month}/${_selectedDeadline!.year}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Icon(Icons.calendar_today, size: 40),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00FFFF),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _updateTask,
                child: Text(
                  'Finish editing',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
