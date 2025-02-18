import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_manager_io/screens/add_task.dart';
import 'package:task_manager_io/screens/profile_screen.dart';
import 'package:task_manager_io/screens/task_details.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';  // for Task model

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Track sort order (true => descending by priority)
  bool _isDescending = true;

  /// Simple pagination: how many tasks to show per “page”
  int _tasksPerPage = 5;
  int _currentPage = 0;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.loggedInUser;
    final String? avatarPath = currentUser?.path_to_avatar; // e.g. set after picking an image
    final allTasks = currentUser?.tasks ?? [];

    // Sort tasks by priority
    final sortedTasks = List<Task>.from(allTasks);
    sortedTasks.sort((a, b) => _isDescending
        ? b.priority.compareTo(a.priority)
        : a.priority.compareTo(b.priority));

    // Paginate for “scroll” functionality
    final startIndex = _currentPage * _tasksPerPage;
    final endIndex =
    (startIndex + _tasksPerPage).clamp(0, sortedTasks.length);
    final pageTasks = sortedTasks.sublist(startIndex, endIndex);

    // Tasks that have a deadline in less than 48 hours
    final upcomingTasks = allTasks.where((task) {
      if (task.deadline == null) return false;
      final diff = task.deadline!.difference(DateTime.now());
      return diff.inHours < 48 && diff.isNegative == false;
    }).toList();

    return Scaffold(
      backgroundColor: Color(0xFFE1FF9B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Could use a CircleAvatar or an Image
                  InkWell(
                    onTap: () {
                      // Navigate to ProfileScreen.
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.purple.shade200,
                      backgroundImage: avatarPath != null && avatarPath.isNotEmpty
                          ? FileImage(File(avatarPath))
                          : AssetImage('assets/images/avatar_default.jpg') as ImageProvider,
                      // If you don't want an overlay icon when the user has a custom avatar,
                      // only show the icon when there's no avatarPath:
                      child: (avatarPath == null || avatarPath.isEmpty)
                          ? Icon(Icons.person, size: 40, color: Colors.white)
                          : null,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Welcome,\n${currentUser?.name ?? "User"}!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Jua',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Left Column: Welcome, tasks list, scroll, counters
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Avatar + Welcome
                          // Sort by priority (with arrow up/down)
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: _toggleSortOrder,
                            icon: Icon(
                              _isDescending ? Icons.arrow_downward : Icons.arrow_upward,
                              color: Colors.black,
                            ),
                            label: Text(
                              'Sort by priority',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Jua',
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          // List of tasks (paged)
                          Expanded(
                            child: ListView(
                              children: pageTasks.map((task) {
                                return _buildPriorityTaskTile(task);
                              }).toList(),
                            ),
                          ),

                          // “Scroll through tasks” button
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0AD800),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                // if we can go to next page
                                if (endIndex < sortedTasks.length) {
                                  _currentPage++;
                                } else {
                                  // reset or do nothing
                                  _currentPage = 0;
                                }
                              });
                            },
                            icon: Icon(Icons.arrow_circle_right),
                            label: Text(
                              'Scroll tasks',
                              style: TextStyle(
                                fontFamily: 'Jua',
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),

                          // Finished / Unfinished tasks counters
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF00FF37),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Finished tasks\n${allTasks.where((t) => t.done).length}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Jua',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF00EEFF),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Tasks to finish\n${allTasks.where((t) => !t.done).length}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Jua',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),

                    SizedBox(width: 18),

                    // Right Column: "Looks like you’ve got quite a lot to do!",
                    // "Assign task" button, tasks with upcoming deadlines
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 30),
                          // A decorative image or placeholder on the top right
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Image.asset(
                              'assets/images/img2.jpg',
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0AD800),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: () {
                              // Go to AddTask screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddTask()),
                              );
                            },
                            child: Text(
                              'Add task',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Tasks with upcoming deadlines...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 16),

                          // List of upcoming tasks with < 2 days left
                          Expanded(
                            child: Scrollbar(
                              thumbVisibility: true,
                             // trackVisibility: true,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    children: upcomingTasks.map((task) {
                                      final timeDiff = task.deadline!.difference(DateTime.now());
                                      return _buildUpcomingDeadlineTile(task, timeDiff);
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Toggle sort order between ascending and descending
  void _toggleSortOrder() {
    setState(() {
      _isDescending = !_isDescending;
      _currentPage = 0; // reset pagination when toggling sort
    });
  }

  /// Builds a task entry showing its priority, name, and check icon if done
  Widget _buildPriorityTaskTile(Task task) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () {
          // Go to TaskDetails
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetailsScreen(task: task)),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Priority circle
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  task.priority.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 15),
            // Task name
            Expanded(
              child: Text(
                task.name,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // Completion check
            task.done
                ? Icon(Icons.check_circle, color: Colors.green, size: 28)
                : Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 28),
          ],
        ),
      ),
    );
  }

  /// Builds a tile for an upcoming deadline task: pink box with name, short desc, time left
  Widget _buildUpcomingDeadlineTile(Task task, Duration diff) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFFC0CB), // or a pinkish color
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Task name
                Text(
                  task.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Jua',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
                // Short description
                Text(
                  task.description ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontFamily: 'Jua',
                  ),
                ),
                SizedBox(height: 6),
                // Time left
                Text(
                  _formatDeadline(diff),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: 'Jua',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Convert a Duration to a human-readable string, e.g. “1 day, 16 hours and 24 minutes”
  String _formatDeadline(Duration diff) {
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;

    List<String> parts = [];
    if (days > 0) {
      parts.add('$days day${days == 1 ? '' : 's'}');
    }
    if (hours > 0) {
      parts.add('$hours hour${hours == 1 ? '' : 's'}');
    }
    if (minutes >= 0) {
      parts.add('$minutes minute${minutes == 1 ? '' : 's'}');
    }

    // Join with “and” before the last part
    if (parts.length > 1) {
      final last = parts.removeLast();
      return parts.join(', ') + ' and $last';
    } else {
      return parts.isEmpty ? 'No time left' : parts.first;
    }
  }
}
