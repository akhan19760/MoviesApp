import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app_project/main.dart';
import 'package:mobile_app_project/model/movie_model.dart';
import 'package:mobile_app_project/model/user_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TMDBAPIs {
  global g = global();
  getPopularMovies() async {
    return g.tmdbWithCustomLogs.v3.trending
        .getTrending(mediaType: MediaType.movie);
  }

  getNowPlayingMovies() async {
    return await g.tmdbWithCustomLogs.v3.movies.getNowPlaying();
  }

  getTopRatedMovies() async {
    return await g.tmdbWithCustomLogs.v3.movies.getTopRated();
  }

  getSimilarMovies(movieId) async {
    return await g.tmdbWithCustomLogs.v3.movies.getSimilar(movieId);
  }

  getMoviesById(List<int> movieIds) async {
    var movies = [];

    for (var m in movieIds) {
      movies.add(await g.tmdbWithCustomLogs.v3.movies.getDetails(m));
    }
    return movies;
  }

  getUpcomingMovies() async {
    return await g.tmdbWithCustomLogs.v3.movies.getUpcoming();
  }

  getMovieVideoUrl(movieId) async {
    return await g.tmdbWithCustomLogs.v3.movies.getVideos(movieId);
  }

  getGenreMovies(genreId) async {
    return await g.tmdbWithCustomLogs.v3.discover
        .getMovies(withGenres: genreId.toString());
  }

  getGenreList() async {
    print(await g.tmdbWithCustomLogs.v3.genres.getMovieList(language: 'en-US'));
    return await g.tmdbWithCustomLogs.v3.genres.getMovieList(language: 'en-US');
  }

  getMovieCredits(movieId) async {
    return await g.tmdbWithCustomLogs.v3.movies.getCredits(movieId);
  }

  getMovieGenres(movieId) async {
    print(await g.tmdbWithCustomLogs.v3.movies.getDetails(movieId));
    return await g.tmdbWithCustomLogs.v3.movies.getDetails(movieId);
  }

  getMovieFavorites(List<dynamic> movieFavs) async {
    List<dynamic> movies = [];
    for (var mf in movieFavs) {
      movies.add(await g.tmdbWithCustomLogs.v3.movies.getDetails(mf));
    }
    print(movies);
    return movies;
  }
}
