import 'package:flutter/material.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/view/movie_tvshows/movie_tv_details.dart';
import 'package:movies_app/widgets/common_widgets/back_button.dart';

// import 'package:movies_app/widgets/';
import 'package:movies_app/widgets/common_widgets/poppins_text.dart';

class GenrePage extends StatefulWidget {
  const GenrePage(
      {super.key, required this.genreName, required this.genreMovies});
  final String imageUrl = 'https://image.tmdb.org/t/p/w500';

  final String? genreName;
  final List<Movie>? genreMovies;

  @override
  State<GenrePage> createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09101d),
      appBar: AppBar(
        backgroundColor: Color(0xff246fdb),
        leading: backButton(),
        title: Text(widget.genreName!),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            children: widget.genreMovies!
                .map(
                  (movie) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieTvDetails(movie: movie)));
                    },
                    child: Container(
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
                              height: 350,
                              child: Image.network(
                                widget.imageUrl + movie.posterPath,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}
