import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_project/view/auth/login_page.dart';
import 'package:mobile_app_project/widgets/common_widgets/back_button.dart';
import 'package:mobile_app_project/widgets/common_widgets/custom_button.dart';
import 'package:mobile_app_project/widgets/common_widgets/custom_textfield.dart';
import 'package:mobile_app_project/widgets/common_widgets/poppins_text.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController oldpassword = TextEditingController();
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    newPassword;
    confirmPassword;
    oldpassword;
    formKey;
  }

  @override
  void dispose() {
    super.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    oldpassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09101d),
      appBar: AppBar(
        backgroundColor: Color(0xff09101d),
        elevation: 0,
        leading: backButton(),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  poppinsText(
                    text: 'Change your \nPassword',
                    size: 48.0,
                    fontBold: FontWeight.bold,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 50),
                  CustomTextfield(
                      hintText: 'Old Password',
                      sufix: const SizedBox(),
                      errorText: 'Old Password cannot be empty',
                      textFieldController: oldpassword,
                      obscureText: true,
                      prefix: Icon(
                        Icons.lock,
                        color: Color(0xff246fdb),
                      )),
                  CustomTextfield(
                      hintText: 'Password',
                      sufix: const SizedBox(),
                      errorText: 'Password cannot be empty',
                      textFieldController: newPassword,
                      obscureText: true,
                      prefix: Icon(
                        Icons.lock,
                        color: Color(0xff246fdb),
                      )),
                  // Confirm Password
                  CustomTextfield(
                      hintText: 'Confirm Password',
                      sufix: const SizedBox(),
                      errorText: newPassword.text != confirmPassword.text
                          ? 'Passwords do not match'
                          : null,
                      textFieldController: confirmPassword,
                      obscureText: true,
                      prefix: Icon(
                        Icons.lock,
                        color: Color(0xff246fdb),
                      )),
                  CustomButton(
                    text: 'Update Password',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        changePassword(
                            oldPass: oldpassword.text.trim(),
                            newPass: newPassword.text.trim());
                      }
                    },
                    color1: Color(0xff246fdb),
                    color2: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  changePassword({required newPass, required oldPass}) async {
    final user = FirebaseAuth.instance.currentUser;
    final credential =
        EmailAuthProvider.credential(email: user!.email!, password: oldPass);
    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPass);
      FirebaseAuth.instance.signOut().whenComplete(() {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}
