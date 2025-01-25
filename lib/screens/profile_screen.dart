import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_io/screens/edit_profile_screen.dart';
import 'package:task_manager_io/screens/login_screen.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Example state for toggling notifications
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.loggedInUser;
    final name = currentUser?.name;
    final email = currentUser?.email;
    final about = currentUser?.about ?? 'No info provided';
    final avatarPath = currentUser?.path_to_avatar;

    return Scaffold(
      body: Center(
        child: Container(
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
              // Title: "Your profile"
              Positioned(
                left: 148,
                top: 50,
                child: SizedBox(
                  width: 403,
                  height: 73,
                  child: Text(
                    'Your profile',
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

              // Left decorative image
              Positioned(
                left: 12,
                top: -34,
                child: Container(
                  width: 179,
                  height: 228,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // Replace with your actual image asset or network
                      image: AssetImage('assets/images/img1.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // Right decorative image
              Positioned(
                left: 509,
                top: -37,
                child: Container(
                  width: 184,
                  height: 210,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // Replace with your actual image asset or network
                      image: AssetImage('assets/images/img2.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // Name label (the green rectangle with "Name")
              Positioned(
                left: 33,
                top: 285,
                child: Container(
                  width: 212,
                  height: 70,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 25,
                        top: 0,
                        child: Container(
                          width: 162,
                          height: 70,
                          decoration: ShapeDecoration(
                            color: Color(0xFF00FF2E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 11.88,
                        child: SizedBox(
                          width: 212,
                          height: 32.12,
                          child: Text(
                            'Name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Email label (the green rectangle with "Email")
              Positioned(
                left: 58,
                top: 372,
                child: Container(
                  width: 162,
                  height: 56,
                  decoration: ShapeDecoration(
                    color: Color(0xFF00FF2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(  // Center the text vertically and horizontally
                    child: Text(
                      'Email',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,  // Reduced font size to fit
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              // About label (the green rectangle with "About")
              Positioned(
                left: 18,
                top: 459,
                child: Container(
                  width: 245,
                  height: 70,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 35.71,
                        top: 0,
                        child: Container(
                          width: 171.60,
                          height: 70,
                          decoration: ShapeDecoration(
                            color: Color(0xFF00FF2E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 12,
                        child: SizedBox(
                          width: 245,
                          height: 32.12,
                          child: Text(
                            'About',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Edit profile button
              Positioned(
                left: 18,
                top: 737,
                child: InkWell(
                  onTap: _onEditProfile,
                  child: Container(
                    width: 245,
                    height: 70,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 28.89,
                          top: 0,
                          child: Container(
                            width: 187.22,
                            height: 70,
                            decoration: ShapeDecoration(
                              color: Color(0xFF00FFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 11.88,
                          child: SizedBox(
                            width: 245,
                            height: 32.12,
                            child: Text(
                              'Edit profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Toggle notifications button
              Positioned(
                left: 251,
                top: 736,
                child: InkWell(
                  onTap: _onToggleNotifications,
                  child: Container(
                    width: 198,
                    height: 70,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 4.89,
                          top: 0,
                          child: Container(
                            width: 187.22,
                            height: 70,
                            decoration: ShapeDecoration(
                              color: Color(0xFF00FFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 7,
                          child: SizedBox(
                            width: 198,
                            height: 32,
                            child: Text(
                              'Toggle notifications',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Sign out button
              Positioned(
                left: 438,
                top: 737,
                child: InkWell(
                  onTap: _onSignOut,
                  child: Container(
                    width: 245,
                    height: 70,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 28.89,
                          top: 0,
                          child: Container(
                            width: 187.22,
                            height: 70,
                            decoration: ShapeDecoration(
                              color: Color(0xFF00FFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 11.88,
                          child: SizedBox(
                            width: 245,
                            height: 32.12,
                            child: Text(
                              'Sign out',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Email white box and text
              Positioned(
                left: 236,
                top: 372,
                child: Container(
                  width: 459,
                  height: 56,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    child: Text(
                      email!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              // "About" white box and text
              Positioned(
                left: 236,
                top: 459,
                child: Container(
                  width: 458,
                  height: 239.61,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      about,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              // Name white box and text
              Positioned(
                left: 234.75,
                top: 289,
                child: Container(
                  width: 190.70,
                  height: 57.72,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: Text(
                      name!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Jua',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 80,
                top: 174,
                child: Container(
                  width: 107,
                  height: 97,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFEADDFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  // Show user's saved avatar if it exists, otherwise show the default asset.
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/avatar_default.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Right side large illustration
              Positioned(
                left: 403,
                top: 125,
                child: Container(
                  width: 277,
                  height: 264,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // Replace with your actual image asset or network
                      image: AssetImage('assets/images/profile_screen_illustration.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Called when user taps "Edit profile"
  void _onEditProfile() {
    // Example: navigate to an EditProfileScreen or open a dialog
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );
  }

  /// Called when user taps "Toggle notifications"
  void _onToggleNotifications() {
    setState(() {
      _notificationsEnabled = !_notificationsEnabled;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_notificationsEnabled
            ? 'Notifications enabled'
            : 'Notifications disabled'),
      ),
    );
  }

  /// Called when user taps "Sign out"
  void _onSignOut() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.signOut();

    // For example, navigate back to a login screen:
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
