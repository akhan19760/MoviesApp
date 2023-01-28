import 'package:flutter/material.dart';
import 'package:mobile_app_project/widgets/common_widgets/poppins_text.dart';

Widget seeMore(String text) {
  return Align(
    child: Container(
      width: 60,
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
          alignment: Alignment.center,
          child: poppinsText(
              text: text,
              size: 10.0,
              fontBold: FontWeight.normal,
              color: Colors.white)),
    ),
  );
}
