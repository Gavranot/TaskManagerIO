
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_io/screens/edit_profile_screen.dart';
import 'package:task_manager_io/screens/login_screen.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State createState() => _ProfileScreenState();
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
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed:() => _onEditProfile.call(),
              icon: Icon(Icons.edit))
        ],
      ),
      backgroundColor: Color(0xFFE1FF9B),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Right decorative image
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
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
                ],
              ),
              Text(
                'Name:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withAlpha(150),
                  fontSize: 18,
                  fontFamily: 'Jua',
                ),
              ),
              Text(
                name!,
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

              // Email label (the green rectangle with "Email")
              Text(
                'Email:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withAlpha(150),
                  fontSize: 18, // Reduced font size to fit
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                email!,
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
                'About:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withAlpha(150),
                  fontSize: 18,
                  fontFamily: 'Jua',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                about,
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

              // SwitchListTile(
              //   title: const Text(
              //     'Notifications',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 24,
              //       fontFamily: 'Jua',
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              //   secondary: const Icon(Icons.notifications_active, color: Colors.black,),
              //   value: _notificationsEnabled,
              //   onChanged: (bool value) {
              //     setState(() {
              //       _notificationsEnabled = value;
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(
              //           content: Text(_notificationsEnabled
              //               ? 'Notifications enabled'
              //               : 'Notifications disabled'),
              //         ),
              //       );
              //     });
              //   },
              // ),
              SizedBox(height: 16,),

              // Sign out button
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _onSignOut,
                    child: Container(decoration: ShapeDecoration(
                      color: Color(0xFF00FFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
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
                  ),
                ],
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

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
          (Route<dynamic> route) => false,
    );
  }
}
