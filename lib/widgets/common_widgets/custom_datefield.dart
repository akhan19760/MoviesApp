import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CustomDateField extends StatefulWidget {
  const CustomDateField({
    super.key,
    required this.hintText,
    required this.textFieldController,
  });

  final String hintText;
  final TextEditingController textFieldController;

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: TextField(
          controller: widget.textFieldController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 15, left: 16),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xff246fdb),
              ),
            ),
            prefixIcon: Icon(
              Icons.calendar_today,
              color: Color(0xff246fdb),
            ),
            hintText: widget.hintText,
            hintStyle: GoogleFonts.poppins(fontSize: 14.0),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
                builder: (context, child) {
                  return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Color(0xff246fdb),
                          onPrimary: Color(0xff09101d),
                          onSurface: Color(0xff09101d),
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Color(0xff09101d), // button text color
                          ),
                        ),
                      ),
                      child: child!);
                });

            if (pickedDate != null) {
              print(pickedDate);
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              print(formattedDate);

              setState(() {
                widget.textFieldController.text = formattedDate;
              });
            } else {
              print("Date is not selected");
            }
          }),
    );
  }
}
