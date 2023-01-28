import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_project/widgets/common_widgets/see_more.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(150, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      child: secondHalf.isEmpty
          ? Column(
              children: [
                Text(firstHalf,
                    style: GoogleFonts.poppins(
                        color: Colors.grey.shade400, fontSize: 14.0)),
              ],
            )
          : Column(
              children: <Widget>[
                Text(
                  flag ? (firstHalf) : (firstHalf + secondHalf),
                  style: GoogleFonts.poppins(
                      color: Colors.grey.shade400, fontSize: 14.0),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      flag ? seeMore('See more') : seeMore('See less'),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
