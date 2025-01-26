import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_io/screens/profile_screen.dart';
import '../providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State createState() => _EditProfileScreenState();
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
      appBar: AppBar(
        title: const Text('Edit your profile'),
        actions: [
          IconButton(
              onPressed: () => _finishEditing.call(), icon: Icon(Icons.save))
        ],
      ),
      backgroundColor: Color(0xFFE1FF9B),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title: "Editing your profile"

            // User avatar circle
            Container(
              width: 100,
              height: 100,
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

            SizedBox(
              height: 16,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            TextField(
              controller: _aboutController,
              decoration: InputDecoration(
                labelText: 'About',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
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

    Navigator.pop(context);

    // Go back, or navigate to another screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }
}
