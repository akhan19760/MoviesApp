import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_project/model/movie_model.dart';
import 'package:mobile_app_project/model/tv_model.dart';
import 'package:mobile_app_project/providers/movie_provider.dart';
import 'package:mobile_app_project/providers/review_provider.dart';
import 'package:mobile_app_project/repositories/movie_repository.dart';
import 'package:mobile_app_project/repositories/review_repository.dart';
import 'package:mobile_app_project/view/review/add_review.dart';
import 'package:mobile_app_project/view/review/all_reviews.dart';
import 'package:mobile_app_project/widgets/common_widgets/back_button.dart';
import 'package:mobile_app_project/widgets/common_widgets/icon_plus_text.dart';
import 'package:mobile_app_project/widgets/common_widgets/icon_text_container.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/cast_slider.dart';
import 'package:mobile_app_project/widgets/common_widgets/expandable_text.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/favorite_button.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/genre_slider.dart';
import 'package:mobile_app_project/widgets/common_widgets/horizontal_divider.dart';
import 'package:mobile_app_project/widgets/common_widgets/rating_bar.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/movie_info.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/movie_poster.dart';
import 'package:mobile_app_project/widgets/review_widgets/review_list.dart';
import 'package:provider/provider.dart';

class MovieTvDetails extends StatefulWidget {
  MovieTvDetails({super.key, this.movie, this.tvshow});
  final String imageUrl = 'https://image.tmdb.org/t/p/w500';

  Movie? movie;
  Tv? tvshow;

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
    ReviewRepository rr = ReviewRepository();
    context.read<MovieProvider>().cast = await mr.getCast(widget.movie!.id);
    context.read<MovieProvider>().movieGenres =
        await mr.getMovieGenres(widget.movie!.id);
    context.read<ReviewProvider>().showReviews =
        await rr.getShowReviews(widget.movie!.id);
    context.read<MovieProvider>().videoUrl =
        await mr.getVideoUrl(widget.movie!.id);
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
            flexibleSpace: context.watch<MovieProvider>().videoUrl != null &&
                    context.watch<TvProvider>().videoUrl != null
                ? FlexibleSpaceBar(
                    background: MoviePoster(
                    image: widget.movie != null
                        ? widget.movie!.posterPath
                        : widget.tvshow!.posterPath,
                    posterUrl: widget.movie != null
                        ? context.read<MovieProvider>().videoUrl!
                        : context.read<TvProvider>().videoUrl!,
                    showName: widget.movie != null
                        ? widget.movie!.originalTitle
                        : widget.tvshow!.originalName,
                  ))
                : Container(),
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
                        title(
                            widget.movie != null
                                ? widget.movie!.originalTitle!
                                : widget.tvshow!.originalName!,
                            16),
                        Spacer(),
                        widget.movie != null
                            ? FavoriteButton(
                                movie: widget.movie,
                              )
                            : FavoriteButton(
                                tv: widget.tvshow,
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
                              Icons.star,
                              widget.movie != null
                                  ? widget.movie!.voteAverage!.round()
                                  : widget.tvshow!.voteAverage!.round()),
                        ]),
                        widget.movie != null
                            ? (context.watch<MovieProvider>().movieGenres !=
                                    null
                                ? GenreSlider(
                                    genres: context
                                        .read<MovieProvider>()
                                        .movieGenres,
                                  )
                                : Container())
                            : (context.watch<TvProvider>().tvGenres != null
                                ? GenreSlider(
                                    genres: context.read<TvProvider>().tvGenres,
                                  )
                                : Container()),
                        MovieInfo(
                          releaseDate: widget.movie != null
                              ? widget.movie!.releaseDate.toString()
                              : widget.tvshow!.firstAirDate,
                          language: widget.movie != null
                              ? widget.movie!.originalLanguage!.toUpperCase()
                              : widget.tvshow!.originalLanguage!.toUpperCase(),
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
                          child: ExpandableText(
                              text: widget.movie != null
                                  ? widget.movie!.overview!
                                  : widget.tvshow!.overview!),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.0),
                  HorizontalDivider(),

                  //Episode Guide
                  // widget.tvshow != null
                  //     ? Container(
                  //         padding: EdgeInsets.all(15),
                  //         child: IconTextContainer(
                  //           icon: Icons.arrow_forward,
                  //           text: 'Episode Guide',
                  //           onTap: () {
                  //             Navigator.of(context).push(MaterialPageRoute(
                  //                 builder: (context) => EpisodeGuide(seasons: widget.tvshow!.seasons!,)));
                  //           },
                  //         ),
                  //       )
                  //     : Container(
                  //         child: null,
                  //       ),

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
                        widget.movie != null
                            ? (context.watch<MovieProvider>().cast != null
                                ? CastSlider(
                                    casts: context.read<MovieProvider>().cast)
                                : Container())
                            : (context.watch<TvProvider>().cast != null
                                ? CastSlider(
                                    casts: context.read<TvProvider>().cast)
                                : Container()),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.0),
                  HorizontalDivider(),

                  //User Reviews
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                    child: Row(
                      children: [
                        verticalBar(),
                        SizedBox(width: 5),
                        title(
                          'User Reviews',
                          20,
                        ),
                      ],
                    ),
                  ),

                  //User Reviews
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Add a review
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: IconTextContainer(
                          text: 'Add a Review',
                          icon: Icons.add,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => widget.movie != null
                                    ? AddReview(
                                        showName: widget.movie!.originalTitle,
                                        releaseDate: widget.movie!.releaseDate,
                                        posterPath: widget.movie!.posterPath,
                                        showId: widget.movie!.id)
                                    : AddReview(
                                        showName: widget.tvshow!.originalName,
                                        releaseDate:
                                            widget.tvshow!.firstAirDate,
                                        posterPath: widget.tvshow!.posterPath,
                                        showId: widget.tvshow!.id)));
                          },
                        ),
                      ),

                      //Review list
                      context.watch<ReviewProvider>().showReviews != null
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: ReviewList(
                                reviews:
                                    context.read<ReviewProvider>().showReviews,
                              ))
                          : Container(),

                      //See all reviews
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => widget.movie != null
                                    ? AllReviews(
                                        showId: widget.movie!.id,
                                        showName: widget.movie!.originalTitle)
                                    : AllReviews(
                                        showId: widget.tvshow!.id,
                                        showName:
                                            widget.tvshow!.originalName)));
                          },
                          child: title(
                            'SEE ALL MOVIE REVIEWS',
                            16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
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
