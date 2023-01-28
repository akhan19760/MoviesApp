import 'package:flutter/material.dart';
import 'package:mobile_app_project/providers/movie_provider.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/carousel_image_slider.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/movie_list.dart';
import 'package:mobile_app_project/widgets/common_widgets/poppins_text.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/movie_category.dart';
import 'package:provider/provider.dart';

class MovieTab extends StatefulWidget {
  const MovieTab({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieTab> createState() => _MovieTabState();
}

class _MovieTabState extends State<MovieTab>
    with AutomaticKeepAliveClientMixin<MovieTab> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            context.watch<MovieProvider>().popularMovies == []
                ? CircularProgressIndicator()
                : MovieCategory(
                    imageSlider: CarouselImageSlider(
                      movieList: context.read<MovieProvider>().popularMovies,
                    ),
                    title: poppinsText(
                        text: 'Popular',
                        size: 16.0,
                        fontBold: FontWeight.bold,
                        color: Colors.white),
                  ),
            MovieCategory(
              imageSlider: MovieList(
                movieList: context.read<MovieProvider>().popularMovies,
              ),
              title: poppinsText(
                  text: 'Trending',
                  size: 16.0,
                  fontBold: FontWeight.bold,
                  color: Colors.white),
            ),
            MovieCategory(
              imageSlider: MovieList(
                movieList: context.read<MovieProvider>().nowPlayingMovies,
              ),
              title: poppinsText(
                  text: 'Upcoming',
                  size: 16.0,
                  fontBold: FontWeight.bold,
                  color: Colors.white),
            ),
            MovieCategory(
              imageSlider: MovieList(
                movieList: context.read<MovieProvider>().topRatedMovies,
              ),
              title: poppinsText(
                  text: 'Top Rated',
                  size: 16.0,
                  fontBold: FontWeight.bold,
                  color: Colors.white),
            ),
            MovieCategory(
              imageSlider: MovieList(
                movieList: context.read<MovieProvider>().upcomingMovies,
              ),
              title: poppinsText(
                  text: 'Latest',
                  size: 16.0,
                  fontBold: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
