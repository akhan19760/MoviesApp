import 'package:flutter/material.dart';
import 'package:mobile_app_project/model/movie_model.dart';
import 'package:mobile_app_project/widgets/common_widgets/poppins_text.dart';

class GenreSlider extends StatefulWidget {
  GenreSlider({Key? key, required this.genres}) : super(key: key);

  final List<String>? genres;

  @override
  State<GenreSlider> createState() => _GenreSliderState();
}

class _GenreSliderState extends State<GenreSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: widget.genres!
              .map(
                (genre) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Color(0xff246fdb),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: poppinsText(
                        text: genre,
                        fontBold: FontWeight.w500,
                        color: Colors.white,
                        size: 12.0),
                  ),
                ),
              )
              .toList()),
    );
  }
}
