import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_project/API_KEYS.dart';
import 'package:mobile_app_project/providers/movie_provider.dart';
import 'package:mobile_app_project/providers/review_provider.dart';
import 'package:mobile_app_project/providers/tv_provider.dart';
import 'package:mobile_app_project/providers/user_provider.dart';
import 'package:mobile_app_project/view/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app_project/view/auth/popcorn_loader.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_api/tmdb_api.dart';

enum SampleItem { itemOne, itemTwo }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(
          create: (_) => MovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReviewProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TvProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PopcornFlix',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(primary: const Color(0xFF09101D)),
      ),
      home: Scaffold(
        backgroundColor: Color(0xff246fdb),
        body: Center(
          child: PopcornIcon(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class global {
  API_KEYS keys = API_KEYS();
  late var tmdbWithCustomLogs = TMDB(
    //TMDB instance
    ApiKeys(
        keys.apiKey, keys.readaccesstoken), //ApiKeys instance with your keys,
  );
}
