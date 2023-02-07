import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/repositories/movie_repository.dart';
import 'package:movies_app/view/Profile/profile.dart';
import 'package:movies_app/view/movie_tvshows/favorites_page.dart';
import 'package:movies_app/view/wrapper/bottom_navbar.dart';
import 'package:movies_app/view/movie_tvshows/user_feed.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  void onTabTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      _selectedIndex = page;
    });
  }

  @override
  void initState() {
    super.initState();
    callMovies();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  callMovies() async {
    MovieRepository mr = MovieRepository();
    context.read<MovieProvider>().popularMovies = await mr.getPopularMovies();
    context.read<MovieProvider>().nowPlayingMovies =
        await mr.getNowPlayingMovies();
    context.read<MovieProvider>().topRatedMovies = await mr.getTopRatedMovies();
    context.read<MovieProvider>().upcomingMovies = await mr.getUpcomingMovies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _pages = <Widget>[
    UserFeed(),
    FavoritesPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09101d),
      bottomNavigationBar: bottomNavbar(_selectedIndex, onTabTapped),
      body: PageView(
        onPageChanged: onPageChanged,
        controller: _pageController,
        children: _pages,
      ),
    );
  }
}
