import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/model/user_model.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:movies_app/repositories/user_repository.dart';
import 'package:movies_app/view/auth/fill_info_screen.dart';
import 'package:movies_app/widgets/common_widgets/back_button.dart';
import 'package:movies_app/widgets/common_widgets/poppins_text.dart';
import 'package:movies_app/widgets/common_widgets/custom_button.dart';
import 'package:movies_app/view/auth/login_page.dart';
import 'package:movies_app/widgets/common_widgets/custom_textfield.dart';
import 'package:movies_app/widgets/common_widgets/social_login_button.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/network/network.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  Network network = Network();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email;
    password;
    confirmPassword;
    formKey;
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09101d),
      appBar: AppBar(
        backgroundColor: Color(0xff09101d),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff246fdb),
              ),
            )
          : ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        poppinsText(
                          text: 'Create your \nAccount',
                          size: 48.0,
                          fontBold: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 50),

                        // Email
                        CustomTextfield(
                            hintText: 'Email',
                            sufix: const SizedBox(),
                            errorText: 'Email cannot be empty',
                            textFieldController: email,
                            obscureText: false,
                            prefix: Icon(
                              Icons.email,
                              color: Color(0xff246fdb),
                            )),

                        //Password
                        CustomTextfield(
                            hintText: 'Password',
                            sufix: const SizedBox(),
                            errorText: 'Password cannot be empty',
                            textFieldController: password,
                            obscureText: true,
                            prefix: Icon(
                              Icons.lock,
                              color: Color(0xff246fdb),
                            )),

                        // Confirm Password
                        CustomTextfield(
                            hintText: 'Confirm Password',
                            sufix: const SizedBox(),
                            errorText: password.text != confirmPassword.text
                                ? 'Passwords do not match'
                                : null,
                            textFieldController: confirmPassword,
                            obscureText: true,
                            prefix: Icon(
                              Icons.lock,
                              color: Color(0xff246fdb),
                            )),

                        // Signup Button
                        CustomButton(
                          text: 'Sign up',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await network.createNewUser(
                                    email: email.text.trim(),
                                    password: password.text.trim());

                                setState(() {
                                  isLoading = false;
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FillProfileScreen(
                                          email: email.text.trim(),
                                        )));
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
                            }
                          },
                          color1: Color(0xff246fdb),
                          color2: Colors.white,
                        ),
                        const SizedBox(height: 40),

                        // Already have an account
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginPage()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              poppinsText(
                                text: 'Already have an account? ',
                                size: 14.0,
                                fontBold: FontWeight.bold,
                                color: Colors.white,
                              ),
                              poppinsText(
                                text: 'Signin',
                                size: 14.0,
                                fontBold: FontWeight.bold,
                                color: Color(0xff246fdb),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
