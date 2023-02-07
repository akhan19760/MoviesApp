import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/model/user_model.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:movies_app/repositories/user_repository.dart';
import 'package:movies_app/widgets/common_widgets/custom_datefield.dart';
import 'package:movies_app/widgets/common_widgets/poppins_text.dart';
import 'package:movies_app/widgets/common_widgets/custom_button.dart';
import 'package:movies_app/widgets/common_widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController photo = TextEditingController();
  TextEditingController date = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    date.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09101d),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: poppinsText(
          text: "Edit Profile",
          size: 24.0,
          color: Colors.white,
          fontBold: FontWeight.bold,
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xff246fdb),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),

                            // Name
                            CustomTextfield(
                                hintText:
                                    context.read<UserProvider>().user.name,
                                sufix: const SizedBox(),
                                errorText: 'Name cannot be empty',
                                textFieldController: name,
                                obscureText: false,
                                prefix: Icon(
                                  Icons.abc,
                                  color: Color(0xff246fdb),
                                )),
                            // Address
                            CustomTextfield(
                                hintText:
                                    context.read<UserProvider>().user.email,
                                sufix: const SizedBox(),
                                errorText: 'Email cannot be empty',
                                textFieldController: email,
                                obscureText: false,
                                prefix: Icon(
                                  Icons.email,
                                  color: Color(0xff246fdb),
                                )),

                            // Date of birth
                            CustomDateField(
                              hintText: context.read<UserProvider>().user.name,
                              textFieldController: date,
                            ),
                            const SizedBox(height: 15),

                            // phone number
                            CustomTextfield(
                                hintText: context
                                    .read<UserProvider>()
                                    .user
                                    .phoneNumber,
                                prefix: Icon(
                                  Icons.phone,
                                  color: Color(0xff246fdb),
                                ),
                                sufix: const SizedBox(),
                                errorText: 'Phone number cannot be empty',
                                textFieldController: phone,
                                obscureText: false),
                            const SizedBox(height: 15),
                          ],
                        )
                      ],
                    ),
                  ),
                  CustomButton(
                    text: 'Update',
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        var id = FirebaseAuth.instance.currentUser!.uid;
                        UserModel user = await UserRepository.updateUserProfile(
                            UserModel(
                              uid: id,
                              name: name.text,
                              email: email.text,
                              dateOfBirth: date.text,
                              phoneNumber: phone.text,
                              favMovies:
                                  context.read<UserProvider>().user.favMovies,
                            ),
                            id,
                            context);
                        // ignore: use_build_context_synchronously
                        context.read<UserProvider>().user = user;
                        setState(() {
                          isLoading = false;
                        });
                        name.clear();
                        email.clear();
                        phone.clear();
                        email.clear();
                        date.clear();
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
