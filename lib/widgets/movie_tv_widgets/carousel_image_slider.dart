import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile_app_project/model/movie_model.dart';
import 'package:mobile_app_project/model/tv_model.dart';
import 'package:mobile_app_project/view/movie_tvshows/movie_tv_details.dart';

class CarouselImageSlider extends StatefulWidget {
  CarouselImageSlider({Key? key, this.movieList, this.tvList})
      : super(key: key);

  List<Movie>? movieList;
  List<Tv>? tvList;

  final String imageUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  State<CarouselImageSlider> createState() => _CarouselImageSliderState();
}

class _CarouselImageSliderState extends State<CarouselImageSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
              height: 400,
              viewportFraction: 0.75,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _currentIndex = index;
                  },
                );
              },
            ),
            items: widget.movieList != null
                ? widget.movieList!
                    .map(
                      (movie) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MovieTvDetails(movie: movie)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Card(
                            margin: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            elevation: 6.0,
                            shadowColor: Color(0xff246fdb),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Image.network(
                                    widget.imageUrl + movie.posterPath,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList()
                : widget.tvList!
                    .map(
                      (tv) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MovieTvDetails(
                                    tvshow: tv,
                                  )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Card(
                            margin: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            elevation: 6.0,
                            shadowColor: Color(0xff246fdb),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Image.network(
                                    widget.imageUrl + tv.posterPath!,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList()),
      ],
    );
  }
}
