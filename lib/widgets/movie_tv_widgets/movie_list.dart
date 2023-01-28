import 'package:flutter/material.dart';
import 'package:mobile_app_project/model/movie_model.dart';
import 'package:mobile_app_project/model/tv_model.dart';
import 'package:mobile_app_project/view/movie_tvshows/movie_tv_details.dart';

class MovieList extends StatefulWidget {
  MovieList({Key? key, this.movieList, this.tvList}) : super(key: key);

  List<Movie>? movieList;
  List<Tv>? tvList;
  final String imageUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        height: MediaQuery.of(context).size.height * 0.29,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: widget.movieList != null
                ? widget.movieList!
                    .map(
                      (movie) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MovieTvDetails(
                                    movie: movie,
                                  )));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          width: 180,
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            shadowColor: Color(0xff246fdb),
                            child: Wrap(
                              children: [
                                Image.network(
                                    widget.imageUrl + movie.posterPath),
                              ],
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
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          width: 180,
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            shadowColor: Color(0xff246fdb),
                            child: Wrap(
                              children: [
                                Image.network(widget.imageUrl + tv.posterPath!),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList()));
  }
}
