import 'package:flutter/material.dart';
import 'package:mobile_app_project/widgets/common_widgets/poppins_text.dart';

class SocialLoginButton extends StatelessWidget {
  SocialLoginButton({super.key, required this.onTap});

  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/images/s2.png'), height: 20),
            const SizedBox(
              width: 10,
            ),
            poppinsText(
                text: 'Sign in with Google',
                color: Colors.black,
                fontBold: FontWeight.w500,
                size: 16.0),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
