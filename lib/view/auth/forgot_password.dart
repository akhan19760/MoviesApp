import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_app_project/network/network.dart';
import 'package:mobile_app_project/widgets/common_widgets/back_button.dart';
import 'package:mobile_app_project/widgets/common_widgets/custom_button.dart';
import 'package:mobile_app_project/widgets/common_widgets/custom_textfield.dart';
import 'package:mobile_app_project/widgets/common_widgets/poppins_text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  Network network = Network();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09101d),
      appBar: AppBar(
        backgroundColor: Color(0xff09101d),
        elevation: 0,
      ),
      body: // Email
          Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            // Heading
            poppinsText(
              text: 'Forgot your \nPassword?',
              size: 48.0,
              fontBold: FontWeight.bold,
              color: Colors.white,
            ),
            const SizedBox(height: 30),
            Center(
              child: CustomTextfield(
                  hintText: 'Email',
                  prefix: Icon(
                    Icons.email,
                    color: Color(0xff246fdb),
                  ),
                  sufix: const SizedBox(),
                  errorText: 'Enter a valid email',
                  textFieldController: email,
                  obscureText: false),
            ),
            CustomButton(
              text: 'Send Link',
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                try {
                  await network.forgotPassword(email: email.text.trim());
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully sent reset code to email'),
                      backgroundColor: Color(0xff246fdb),
                      duration: Duration(seconds: 5),
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message!),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    ),
                  );
                }
              },
              color1: Color(0xff246fdb),
              color2: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
