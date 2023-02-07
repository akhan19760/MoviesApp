import 'package:flutter/material.dart';
import 'package:movies_app/widgets/common_widgets/poppins_text.dart';

Widget rowData(String text, Icon icon, VoidCallback onTap) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Row(
      children: [
        SizedBox(height: 28, width: 28, child: icon),
        const SizedBox(width: 16),
        poppinsText(
          text: text,
          size: 18.0,
          fontBold: FontWeight.w500,
          color: text == 'Logout' ? Colors.red : Colors.white,
        ),
        const Expanded(child: SizedBox()),
      ],
    ),
  );
}
