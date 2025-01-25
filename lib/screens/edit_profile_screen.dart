import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:task_manager_io/screens/profile_screen.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Text controllers to edit name, email, about
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _aboutController = TextEditingController();
  String avatarPath = "";



  @override
  void initState() {
    super.initState();
    // Pre-fill with current user data
    final user = Provider.of<UserProvider>(context, listen: false).loggedInUser;
    final userName = user?.name;

    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _aboutController.text = user.about ?? '';
      avatarPath = user.path_to_avatar;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
              // Title: "Editing your profile"
              Positioned(
                left: 148,
                top: 50,
                child: SizedBox(
                  width: 403,
                  height: 73,
                  child: Text(
                    'Editing your profile',
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
                    // Replace with your own asset or network image
                    image: DecorationImage(
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
                    // Replace with your own asset or network image
                    image: DecorationImage(
                      image: AssetImage('assets/images/img2.jpg'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // User avatar circle
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
                      avatarPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // "Change avatar" button
              // Positioned(
              //   left: 220,
              //   top: 185,
              //   child: InkWell(
              //     onTap: _changeAvatar,
              //     child: Container(
              //       width: 170,
              //       height: 50,
              //       decoration: ShapeDecoration(
              //         color: Color(0xFF00FFFF),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //       ),
              //       child: Center(
              //         child: Text(
              //           'Change avatar',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 20,
              //             fontFamily: 'Jua',
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

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
                              fontSize: 36,
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

              // Name TextField
              Positioned(
                left: 235,
                top: 290,
                child: Container(
                  width: 260,
                  height: 57,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: TextField(
                    controller: _nameController,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Jua',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10, top: 10),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => _nameController.clear(),
                      ),
                    ),
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
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 162,
                          height: 56,
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
                        top: 6.4,
                        child: SizedBox(
                          width: 162,
                          height: 17.3,
                          child: Text(
                            'Email',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
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

              // Email TextField
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
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Jua',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 12, top: 14),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => _emailController.clear(),
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
                              fontSize: 36,
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

              // About TextField (multiline)
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
                  child: TextField(
                    controller: _aboutController,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Jua',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),

              // Finish edit button
              Positioned(
                left: 18,
                top: 737,
                child: InkWell(
                  onTap: _finishEditing,
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
                              'Finish edit',
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

              // Cancel button
              Positioned(
                left: 438,
                top: 737,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
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
                              'Cancel',
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

              // Right side large illustration
              Positioned(
                left: 403,
                top: 125,
                child: Container(
                  width: 277,
                  height: 264,
                  decoration: BoxDecoration(
                    // Replace with your own image
                    image: DecorationImage(
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

  /// Called when user taps "Change avatar"
  // void _changeAvatar() async {
  //   final picker = ImagePicker();
  //
  //   // Pick an image from the gallery
  //   final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     final userProvider = Provider.of<UserProvider>(context, listen: false);
  //     final userName = userProvider.loggedInUser?.name ?? 'user';
  //
  //     // Example of forcibly copying to "assets/images/{userName}.jpg"
  //     // (In a production Android/iOS build, this is generally not writable.)
  //     final fileName = '$userName.jpg';
  //     final newPath = p.join('assets', 'images', fileName);
  //
  //     final bytes = await pickedFile.readAsBytes();
  //     final imageProvider = MemoryImage(bytes);
  //
  //     try {
  //       final newFile = await File(pickedFile.path).copy(newPath);
  //
  //       // Update user model
  //       userProvider.loggedInUser?.path_to_avatar = newFile.path;
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('New avatar saved at: ${newFile.path}')),
  //       );
  //     } on FileSystemException catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to save avatar: $e')),
  //       );
  //     }
  //   } else {
  //     // User canceled picking an image
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('No image selected.')),
  //     );
  //   }
  // }

  /// Called when user taps "Finish edit"
  void _finishEditing() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.loggedInUser;

    if (user != null) {
      // Update user data
      user.name = _nameController.text;
      user.email = _emailController.text;
      user.about = _aboutController.text;
      // Optionally call a provider method to persist changes
      // userProvider.updateUser(user);

      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated!')),
      );
    }

    // Go back, or navigate to another screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }
}
