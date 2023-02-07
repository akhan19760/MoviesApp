import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/repositories/movie_repository.dart';
import 'package:movies_app/widgets/common_widgets/back_button.dart';
import 'package:movies_app/widgets/common_widgets/icon_plus_text.dart';
import 'package:movies_app/widgets/movie_tv_widgets/cast_slider.dart';
import 'package:movies_app/widgets/common_widgets/expandable_text.dart';
import 'package:movies_app/widgets/movie_tv_widgets/favorite_button.dart';
import 'package:movies_app/widgets/movie_tv_widgets/genre_slider.dart';
import 'package:movies_app/widgets/common_widgets/horizontal_divider.dart';
import 'package:movies_app/widgets/movie_tv_widgets/movie_info.dart';
import 'package:movies_app/widgets/movie_tv_widgets/movie_poster.dart';
import 'package:provider/provider.dart';

class MovieTvDetails extends StatefulWidget {
  MovieTvDetails({super.key, required this.movie});
  final String imageUrl = 'https://image.tmdb.org/t/p/w500';

  final Movie? movie;

  @override
  State<MovieTvDetails> createState() => _MovieTvDetailsState();
}

class _MovieTvDetailsState extends State<MovieTvDetails> {
  @override
  void initState() {
    super.initState();
    callMovieInfo();
  }

  callMovieInfo() async {
    MovieRepository mr = MovieRepository();
    context.read<MovieProvider>().cast = await mr.getCast(widget.movie!.id);
    context.read<MovieProvider>().movieGenres =
        await mr.getMovieGenres(widget.movie!.id);
    context.read<MovieProvider>().videoUrl =
        await mr.getVideoUrl(widget.movie!.id);
    context.read<MovieProvider>().similarMovies =
        await mr.getSimilarMovies(widget.movie!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xff09101d),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            foregroundColor: Colors.transparent,
            floating: false,
            title: backButton(),
            pinned: true,
            backgroundColor: Color(0xff246fdb),
            expandedHeight: 350,
            flexibleSpace: context.watch<MovieProvider>().videoUrl != null
                ? FlexibleSpaceBar(
                    background: MoviePoster(
                    image: widget.movie!.posterPath,
                    posterUrl: context.read<MovieProvider>().videoUrl!,
                    showName: widget.movie!.originalTitle,
                  ))
                : CircularProgressIndicator(
                    color: Color(0xff246fdb),
                  ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Movie title & Favorite
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        title(widget.movie!.originalTitle!, 16),
                        Spacer(),
                        FavoriteButton(
                          movie: widget.movie,
                        )
                      ],
                    ),
                  ),
                  //Movie rating, Genre list, Movie summary and Rating bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(children: [
                          customIcon(
                              Icons.star, widget.movie!.voteAverage!.round()),
                        ]),
                        context.watch<MovieProvider>().movieGenres != null
                            ? GenreSlider(
                                genres:
                                    context.read<MovieProvider>().movieGenres,
                              )
                            : CircularProgressIndicator(
                                color: Color(0xff246fdb),
                              ),
                        MovieInfo(
                          releaseDate: widget.movie!.releaseDate.toString(),
                          language:
                              widget.movie!.originalLanguage!.toUpperCase(),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  HorizontalDivider(),

                  //Movie Description
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            verticalBar(),
                            SizedBox(width: 5),
                            title(
                              'Description',
                              20,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: ExpandableText(text: widget.movie!.overview!),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.0),
                  HorizontalDivider(),

                  //Cast
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            verticalBar(),
                            SizedBox(width: 5),
                            title(
                              'Cast',
                              20,
                            ),
                          ],
                        ),
                        //Cast slider
                        context.watch<MovieProvider>().cast != null
                            ? CastSlider(
                                casts: context.read<MovieProvider>().cast)
                            : CircularProgressIndicator(
                                color: Color(0xff246fdb),
                              ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget title(String text, double fontsize) {
  return Container(
    child: Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontsize,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
  );
}

Widget customIcon(icon, movieRating) {
  return iconPlusText(icon, '${movieRating.toString()}/10 IMDb',
      Colors.amberAccent, Colors.grey.shade500, 12.0, 12.0);
}

Widget verticalBar() {
  return Container(
    height: 25,
    width: 3,
    color: Color(0xff246fdb),
  );
}
