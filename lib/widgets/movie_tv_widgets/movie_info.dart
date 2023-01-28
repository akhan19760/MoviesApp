import 'package:flutter/material.dart';
import 'package:mobile_app_project/widgets/common_widgets/poppins_text.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    super.key,
    required this.releaseDate,
    required this.language,
  });

  final String? releaseDate;
  final String? language;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        children: [
          SummaryDetail(text1: 'Release Date', text2: releaseDate),
          const SizedBox(
            width: 20,
          ),
          SummaryDetail(text1: 'Language', text2: language),
        ],
      ),
    );
  }
}

class SummaryDetail extends StatelessWidget {
  const SummaryDetail({super.key, required this.text1, required this.text2});

  final String? text1;
  final String? text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: MediaQuery.of(context).size.height,
      width: 100,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: poppinsText(
                text: text1,
                color: Colors.white,
                size: 12.0,
                fontBold: FontWeight.w600),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: poppinsText(
                text: text2,
                color: Colors.grey,
                size: 12.0,
                fontBold: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
