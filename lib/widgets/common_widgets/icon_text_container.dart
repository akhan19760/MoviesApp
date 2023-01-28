import 'package:flutter/material.dart';
import 'package:mobile_app_project/widgets/common_widgets/poppins_text.dart';

class IconTextContainer extends StatelessWidget {
  IconTextContainer(
      {super.key, required this.icon, required this.text, required this.onTap});

  final icon;
  final String text;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Color(0xff246fdb)),
      child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              poppinsText(
                  text: text,
                  fontBold: FontWeight.bold,
                  color: Colors.white,
                  size: 16.0),
              Spacer(),
              Icon(
                icon,
                color: Colors.white,
              ),
            ],
          )),
    );
  }
}
