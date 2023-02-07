import 'package:flutter/material.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/view/movie_tvshows/movie_tv_details.dart';

class MovieList extends StatefulWidget {
  MovieList({Key? key, required this.movieList}) : super(key: key);

  final List<Movie>? movieList;
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
          children: widget.movieList!
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      shadowColor: Color(0xff246fdb),
                      child: Wrap(
                        children: [
                          Image.network(widget.imageUrl + movie.posterPath),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList()),
    );
  }
}
