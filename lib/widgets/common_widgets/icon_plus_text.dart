import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget iconPlusText(icon, text, iconColor, textColor, iconSize, textSize) {
  return Row(
    children: [
      Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
      Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: textSize, color: textColor, fontWeight: FontWeight.w500),
      )
    ],
  );
}
