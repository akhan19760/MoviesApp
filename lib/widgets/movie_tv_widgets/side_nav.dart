import 'package:flutter/material.dart';
import 'package:mobile_app_project/providers/movie_provider.dart';
import 'package:mobile_app_project/repositories/movie_repository.dart';
import 'package:mobile_app_project/view/movie_tvshows/genre_page.dart';
import 'package:mobile_app_project/widgets/common_widgets/poppins_text.dart';
import 'package:mobile_app_project/widgets/common_widgets/horizontal_divider.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app_project/model/movie_model.dart';

class SideNav extends StatefulWidget {
  SideNav({super.key});
  bool isLoading = false;

  @override
  State<SideNav> createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  void initState() {
    super.initState();
    callGenres();
  }

  callGenres() async {
    MovieRepository mr = MovieRepository();
    context.read<MovieProvider>().genres = await mr.getGenreList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff09101d).withOpacity(0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              child: poppinsText(
                  text: 'Genres',
                  size: 24.0,
                  fontBold: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          HorizontalDivider(),
          Expanded(
            child: context.watch<MovieProvider>().genres != null
                ? ListView.builder(
                    itemCount: context.read<MovieProvider>().genres!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Column(children: [
                      InkWell(
                        onTap: () async {
                          MovieRepository mr = MovieRepository();
                          context.read<MovieProvider>().genreMovies =
                              await mr.getGenreMovies(context
                                  .read<MovieProvider>()
                                  .genres![index]
                                  .id);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GenrePage(
                                    genreName: context
                                        .read<MovieProvider>()
                                        .genres![index]
                                        .name,
                                    genreMovies: context
                                        .read<MovieProvider>()
                                        .genreMovies,
                                  )));
                        },
                        child: ListTile(
                          title: poppinsText(
                              text: context
                                  .read<MovieProvider>()
                                  .genres![index]
                                  .name,
                              size: 18.0,
                              fontBold: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                      HorizontalDivider(),
                    ]),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
