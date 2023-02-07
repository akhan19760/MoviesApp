import 'package:flutter/material.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:movies_app/view/Profile/edit_profile.dart';
import 'package:movies_app/view/auth/change_password.dart';
import 'package:movies_app/view/auth/login_page.dart';
import 'package:movies_app/widgets/common_widgets/custom_button.dart';
import 'package:movies_app/widgets/common_widgets/poppins_text.dart';
import 'package:movies_app/widgets/common_widgets/row_data.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09101d),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 20),
            Row(
              children: [
                const SizedBox(width: 16),
                poppinsText(
                  text: 'Profile',
                  size: 24.0,
                  fontBold: FontWeight.bold,
                  color: Colors.white,
                ),
              ],
            ),
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/user.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      poppinsText(
                        text: context.read<UserProvider>().user.name,
                        size: 24.0,
                        fontBold: FontWeight.w700,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      poppinsText(
                        text: context.read<UserProvider>().user.email,
                        size: 14.0,
                        fontBold: FontWeight.w700,
                        color: Colors.white,
                      ),
                      const Divider(color: Color(0xffEEEEEE)),
                      const SizedBox(height: 20),
                      rowData(
                        "Edit Profile",
                        Icon(
                          Icons.person,
                          color: Color(0xff246fdb),
                        ),
                        () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditProfile()));
                        },
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      rowData(
                        "Change Password",
                        Icon(
                          Icons.lock,
                          color: Color(0xff246fdb),
                        ),
                        () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChangePassword()));
                        },
                      ),
                      const SizedBox(height: 20),
                      rowData(
                        "Logout",
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        () {
                          showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0)),
                              ),
                              builder: (context) {
                                return Container(
                                  height: 280,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        poppinsText(
                                            text: 'Logout',
                                            size: 24.0,
                                            fontBold: FontWeight.w500,
                                            color: Colors.red),
                                        const SizedBox(height: 20),
                                        poppinsText(
                                            text:
                                                'Are you sure you want to Logout',
                                            size: 16.0,
                                            fontBold: FontWeight.w500,
                                            color: Colors.red),
                                        const SizedBox(height: 30),
                                        CustomButton(
                                          color2: Colors.white,
                                          color1: Color(0xff246fdb),
                                          text: "Yes, Logout",
                                          onTap: () {
                                            FirebaseAuth.instance
                                                .signOut()
                                                .then((value) {
                                              Navigator.pop(context);
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginPage()));
                                            });
                                          },
                                        ),
                                        CustomButton(
                                          text: "Cancel",
                                          color2: Color(0xff246fdb),
                                          color1: Colors.white,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                      const SizedBox(height: 100),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
