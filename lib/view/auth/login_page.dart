import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/model/user_model.dart';
import 'package:movies_app/network/network.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:movies_app/repositories/user_repository.dart';
import 'package:movies_app/view/auth/fill_info_screen.dart';
import 'package:movies_app/view/auth/forgot_password.dart';
import 'package:movies_app/view/auth/signup_page.dart';
import 'package:movies_app/view/wrapper/home_page.dart';
import 'package:movies_app/widgets/common_widgets/back_button.dart';
import 'package:movies_app/widgets/common_widgets/custom_button.dart';
import 'package:movies_app/widgets/common_widgets/poppins_text.dart';
import 'package:movies_app/widgets/common_widgets/social_login_button.dart';
import 'package:movies_app/widgets/common_widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Network network = Network();
  bool isLoading = false;
  bool isLogged = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool validateEmail = true;
  bool validatePassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email;
    password;
    formKey;
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
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
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xff246fdb),
              ),
            )
          : ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Heading
                        poppinsText(
                          text: 'Login to your \nAccount',
                          size: 48.0,
                          fontBold: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 50),

                        // Email
                        CustomTextfield(
                            hintText: 'Email',
                            prefix: Icon(
                              Icons.email,
                              color: Color(0xff246fdb),
                            ),
                            sufix: const SizedBox(),
                            errorText: 'Email cannot be empty',
                            textFieldController: email,
                            obscureText: false),

                        // Password
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

                        // Signin Button
                        CustomButton(
                          text: 'Sign in',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await network.signInUser(
                                    email: email.text.trim(),
                                    password: password.text.trim());
                                var id = FirebaseAuth.instance.currentUser!.uid;
                                UserModel user =
                                    await UserRepository.getUserProfile(
                                        id, context);
                                context.read<UserProvider>().user = user;

                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomePage()));
                                setState(() {
                                  isLoading = false;
                                });
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
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Forgot your password?',
                              style: TextStyle(
                                  color: Color(0xff246fdb),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Dont have an account
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUp()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              poppinsText(
                                text: 'SignUp',
                                size: 14.0,
                                fontBold: FontWeight.bold,
                                color: Color(0xff246fdb),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
