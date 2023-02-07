import 'package:movies_app/model/credit_model.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/network/tmdb_apis.dart';

class MovieRepository {
  TMDBAPIs movie = TMDBAPIs();

  getPopularMovies() async {
    var response = await movie.getPopularMovies();
    List<Movie> movies =
        response['results'].map<Movie>((m) => Movie.fromJson(m)).toList();
    return movies;
  }

  getUpcomingMovies() async {
    var response = await movie.getUpcomingMovies();
    List<Movie> movies =
        response['results'].map<Movie>((m) => Movie.fromJson(m)).toList();
    return movies;
  }

  getSimilarMovies(movieId) async {
    var response = await movie.getSimilarMovies(movieId);
    List<Movie> movies =
        response['results'].map<Movie>((m) => Movie.fromJson(m)).toList();
    return movies;
  }

  getNowPlayingMovies() async {
    var response = await movie.getNowPlayingMovies();
    List<Movie> movies =
        response['results'].map<Movie>((m) => Movie.fromJson(m)).toList();
    return movies;
  }

  getTopRatedMovies() async {
    var response = await movie.getTopRatedMovies();
    List<Movie> movies =
        response['results'].map<Movie>((m) => Movie.fromJson(m)).toList();
    return movies;
  }

  getVideoUrl(movieId) async {
    var response = await movie.getMovieVideoUrl(movieId);
    String videoUrl = response['results'][0]['key'];
    return videoUrl;
  }

  getCast(movieId) async {
    var response = await movie.getMovieCredits(movieId);
    List<Cast> fullCast = [];
    //print(response);
    List<Cast> casts =
        response['cast'].map<Cast>((m) => Cast.fromJson(m)).toList();
    for (var cast in casts) {
      if (cast.profilePath != null) {
        fullCast.add(cast);
      }
    }
    return fullCast;
  }

  getGenreList() async {
    var response = await movie.getGenreList();
    List<Genres> genres =
        response['genres'].map<Genres>((g) => Genres.fromJson(g)).toList();
    return genres;
  }

  getGenreMovies(genreId) async {
    var response = await movie.getGenreMovies(genreId);
    List<Movie> genreMovies =
        response['results'].map<Movie>((g) => Movie.fromJson(g)).toList();
    return genreMovies;
  }

  getMovieGenres(movieId) async {
    var response = await movie.getMovieGenres(movieId);
    List<String> genres = [];
    var x = response['genres'];

    for (var v in x) {
      genres.add(v['name']);
      print(v);
    }
    return genres;
  }

  getMovieFavorites(List<dynamic> movieFavs) async {
    var response = await movie.getMovieFavorites(movieFavs);
    List<Movie> favMovies =
        response.map<Movie>((m) => Movie.fromJson(m)).toList();
    print(favMovies);
    return favMovies;
  }
}
