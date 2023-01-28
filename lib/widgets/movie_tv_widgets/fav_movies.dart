import 'package:flutter/material.dart';
import 'package:mobile_app_project/providers/movie_provider.dart';
import 'package:mobile_app_project/providers/user_provider.dart';
import 'package:mobile_app_project/repositories/movie_repository.dart';
import 'package:mobile_app_project/view/movie_tvshows/movie_tv_details.dart';
import 'package:provider/provider.dart';

class FavMovies extends StatefulWidget {
  const FavMovies({super.key});

  final String imageUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  State<FavMovies> createState() => _FavMoviesState();
}

class _FavMoviesState extends State<FavMovies> {
  @override
  void initState() {
    super.initState();
    callFavoriteMovies();
    setState(() {});
  }

  callFavoriteMovies() async {
    MovieRepository mr = MovieRepository();
    context.read<MovieProvider>().favMovies =
        await mr.getMovieFavorites(context.read<UserProvider>().user.favMovies);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    final movieFavs = context.read<MovieProvider>().favMovies;
    return Scaffold(
      backgroundColor: Color(0xff09101d),
      body: context.watch<UserProvider>().user.favMovies.isNotEmpty
          ? Padding(
              padding: EdgeInsets.all(15),
              child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  children: movieFavs!
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
                      .toList()),
            )
          : Container(),
    );
  }
}
