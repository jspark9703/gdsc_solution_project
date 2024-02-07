import 'package:flutter/material.dart';
import 'package:gdsc_solution_project/const/color.dart';
import 'package:gdsc_solution_project/database/dbservice.dart';
import 'package:gdsc_solution_project/models/user_url.dart';
import 'package:gdsc_solution_project/provider/Authcontroller.dart';

class GuideMessage extends StatefulWidget {
  GuideMessage({required this.text, super.key});

  String text;

  @override
  State<GuideMessage> createState() => _GuideMessageState();
}

class _GuideMessageState extends State<GuideMessage> {
  bool isMessageOn = true; // Default value

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    try {
      // Use AuthController to get current user's UID
      String uid = AuthController().getCurrentUser();
      // Fetch user profile using DBService
      User user = await DBService().readProfile(uid);
      // Update isMessageOn based on the user's showMessage value
      if (user.showMessage != null) {
        setState(() {
          isMessageOn = user.showMessage!;
        });
      }
    } catch (e) {
      print("Error fetching user profile: $e");
      // Handle error or set a default value
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50,),
        Visibility(
          visible: isMessageOn,
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 24,
              color: GRAY_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
