import 'package:flutter/material.dart';
import 'package:movies_app/widgets/common_widgets/poppins_text.dart';

class MovieCategory extends StatefulWidget {
  MovieCategory({Key? key, required this.imageSlider, required this.title})
      : super(key: key);

  Widget imageSlider;
  Widget title;

  @override
  State<MovieCategory> createState() => _MovieCategoryState();
}

class _MovieCategoryState extends State<MovieCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: widget.title,
                  ),
                ),
                Spacer(),
              ]),
            ),
          ),
          SizedBox(
            child: widget.imageSlider,
          )
        ],
      ),
    );
  }
}
