import 'package:flutter/material.dart';
import 'package:movies_app/model/credit_model.dart';
import 'package:movies_app/widgets/common_widgets/poppins_text.dart';

class CastSlider extends StatelessWidget {
  const CastSlider({super.key, required this.casts});

  final List<Cast>? casts;
  final String imageUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: casts!
              .map(
                (cast) => Container(
                  width: 180,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    clipBehavior: Clip.hardEdge,
                    elevation: 5.0,
                    child: Column(children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Container(
                          height: 100,
                          child: Image.network(
                            imageUrl + cast.profilePath,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: poppinsText(
                                  text: cast.originalName,
                                  size: 13.0,
                                  fontBold: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: poppinsText(
                                  text: cast.character,
                                  size: 13.0,
                                  fontBold: FontWeight.w500,
                                  color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              )
              .toList()),
    );
  }
}
