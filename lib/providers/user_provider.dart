import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  final List<User> _users = [
    User(
      name: 'John Doe',
      email: 'user1@example.com',
      password: 'password1',
      about: 'I love managing tasks efficiently!',
      path_to_avatar: 'assets/images/avatar_default.jpg',
      tasks: [
        Task(
          name: 'Complete project report',
          description: 'Finalize and submit the report',
          priority: 8.5,
          deadline: DateTime.parse('2025-02-15T10:00:00Z'),
          done: false
        ),
        Task(
          name: 'Prepare presentation',
          description: 'Create slides for the upcoming meeting',
          priority: 7.0,
          deadline: DateTime.parse('2025-01-30T15:00:00Z'),
            done: false
        ),
      ],
    ),
    User(
      name: 'Jane Smith',
      email: 'user2@example.com',
      password: 'password2',
      about: 'Task management enthusiast!',
      path_to_avatar: 'assets/images/avatar_default.jpg',
      tasks: [
        Task(
          name: 'Review pull requests',
          description: 'Go through open PRs and provide feedback',
          priority: 9.0,
          deadline: DateTime.parse('2025-02-10T18:00:00Z'),
          done: false
        ),
      ],
    ),
  ];

  User? _currentUser;
  User? _loggedInUser;

  User? get currentUser => _currentUser;
  User? get loggedInUser => _loggedInUser;

  void addUser(String email, String password) {
    _users.add(User(name: email, password: password, email: email, about: "Example", path_to_avatar: 'assets/images/avatar_default.jpg',
        tasks: []));
    notifyListeners();
  }

  bool login(String email, String password) {
    var matchedUsers = _users.where((user) => user.email == email && user.password == password);

    if (matchedUsers.isNotEmpty) {
      _loggedInUser = matchedUsers.first;
      print('Welcome, ${_loggedInUser!.name}');
      print('You have ${_loggedInUser!.tasks.length} tasks.');
      return true;
    } else {
      _loggedInUser = null;
      print('Invalid email or password');
      return false;
    }
  }

  void signOut(){
    _loggedInUser = null;
  }
  // Register new user
  void registerUser(String name, String email, String password, String about) {
    _currentUser = User(
      name: name,
      password: password,
      email: email,
      about: about,
      path_to_avatar: 'assets/images/avatar_default.jpg',
      tasks: [],
    );
    notifyListeners();
  }

  bool userExists(String email) {
    return _users.any((user) => user.email == email);
  }

  // Add a new task
  void addTask(String name, String description, double priority, DateTime deadline) {
    if (_currentUser != null) {
      _currentUser!.tasks.add(Task(
        name: name,
        description: description,
        priority: priority,
        deadline: deadline,
        done: false,
      ));
      notifyListeners();
    }
  }

  // Remove a task
  void removeTask(String taskName) {
    if (_currentUser != null) {
      _currentUser!.tasks.removeWhere((task) => task.name == taskName);
      notifyListeners();
    }
  }

  // Update a task
  void updateTask(String taskName, String newDescription, double newPriority, DateTime newDeadline, bool isDone) {
    if (_currentUser != null) {
      for (var task in _currentUser!.tasks) {
        if (task.name == taskName) {
          task.description = newDescription;
          task.priority = newPriority;
          task.deadline = newDeadline;
          task.done = isDone;
          break;
        }
      }
      notifyListeners();
    }
  }

  // Clear user on logout
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
