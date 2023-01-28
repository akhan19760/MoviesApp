import 'package:flutter/material.dart';
import 'package:mobile_app_project/model/credit_model.dart';
import 'package:mobile_app_project/model/movie_model.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie>? _popularMovies = [];
  List<Movie>? _upcomingMovies = [];
  List<Movie>? _topRatedMovies = [];
  List<Movie>? _nowPlayingMovies = [];
  List<Movie>? _genreMovies = [];
  List<Movie>? _favMovies = [];
  List<String>? _movieGenres = [];
  List<Genres>? _genres = [];
  String? _videoUrl = '';
  List<Cast>? _cast = [];

  List<Movie>? get popularMovies => _popularMovies;
  List<Movie>? get upcomingMovies => _upcomingMovies;
  List<Movie>? get topRatedMovies => _topRatedMovies;
  List<Movie>? get nowPlayingMovies => _nowPlayingMovies;
  List<Movie>? get genreMovies => _genreMovies;
  List<Movie>? get favMovies => _favMovies;
  List<String>? get movieGenres => _movieGenres;
  List<Genres>? get genres => _genres;
  String? get videoUrl => _videoUrl;
  List<Cast>? get cast => _cast;

  set popularMovies(List<Movie>? pm) {
    _popularMovies = pm;
    notifyListeners();
  }

  set upcomingMovies(List<Movie>? pm) {
    _upcomingMovies = pm;
    notifyListeners();
  }

  set topRatedMovies(List<Movie>? tr) {
    _topRatedMovies = tr;
    notifyListeners();
  }

  set nowPlayingMovies(List<Movie>? np) {
    _nowPlayingMovies = np;
    notifyListeners();
  }

  set genreMovies(List<Movie>? gm) {
    _genreMovies = gm;
    notifyListeners();
  }

  set favMovies(List<Movie>? fm) {
    _favMovies = fm;
    notifyListeners();
  }

  set movieGenres(List<String>? mg) {
    _movieGenres = mg;
    notifyListeners();
  }

  set genres(List<Genres>? g) {
    _genres = g;
    notifyListeners();
  }

  set videoUrl(String? videoUrl) {
    _videoUrl = videoUrl;
    notifyListeners();
  }

  set cast(List<Cast>? cast) {
    _cast = cast;
    notifyListeners();
  }
}
