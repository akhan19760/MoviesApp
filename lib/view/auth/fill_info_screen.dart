import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_project/model/user_model.dart';
import 'package:mobile_app_project/providers/user_provider.dart';
import 'package:mobile_app_project/repositories/user_repository.dart';
import 'package:mobile_app_project/view/auth/login_page.dart';
import 'package:mobile_app_project/view/wrapper/home_page.dart';
import 'package:mobile_app_project/widgets/common_widgets/back_button.dart';
import 'package:mobile_app_project/widgets/common_widgets/custom_button.dart';
import 'package:mobile_app_project/widgets/common_widgets/custom_datefield.dart';
import 'package:mobile_app_project/widgets/common_widgets/poppins_text.dart';
import 'package:mobile_app_project/widgets/common_widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController photo = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09101d),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: backButton(),
        title: poppinsText(
            text: 'Fill your Profile',
            size: 24.0,
            fontBold: FontWeight.bold,
            color: Colors.white),
      ),
      body: Padding(
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
                      Center(
                        child: Container(
                          height: 140,
                          width: 140,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/user.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      CustomTextfield(
                          hintText: 'name',
                          sufix: const SizedBox(),
                          errorText: 'Name cannot be empty',
                          textFieldController: name,
                          obscureText: false,
                          prefix: Icon(
                            Icons.abc,
                            color: Color(0xff246fdb),
                          )),
                      CustomDateField(
                          hintText: 'Date', textFieldController: date),
                      const SizedBox(height: 15),
                      CustomTextfield(
                        hintText: 'Phone number',
                        sufix: const SizedBox(),
                        errorText: 'Phone number cannot be empty',
                        textFieldController: phone,
                        obscureText: false,
                        prefix: Icon(
                          Icons.phone,
                          color: Color(0xff246fdb),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            CustomButton(
              color1: Color(0xff246fdb),
              color2: Colors.white,
              text: "Continue",
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
                          email: widget.email,
                          dateOfBirth: date.text,
                          phoneNumber: phone.text,
                          favMovies: [],
                          favTvs: []),
                      id,
                      context);
                  // ignore: use_build_context_synchronously
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => LoginPage())));
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
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
