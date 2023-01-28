import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app_project/widgets/common_widgets/poppins_text.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/movie_tab.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/side_nav.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/tv_tab.dart';

class UserFeed extends StatefulWidget {
  const UserFeed({Key? key}) : super(key: key);

  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed> {
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(milliseconds: 400),
      length: 2,
      child: Scaffold(
        endDrawer: SideNav(),
        backgroundColor: Color(0xff09101d),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Color(0xff246fdb)),
          title: poppinsText(
            text: 'PopcornFlix',
            size: 24.0,
            fontBold: FontWeight.bold,
            color: Color(0xff246fdb),
          ),
          elevation: 5,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 5,
                  color: Color(0xff246fdb),
                ),
                insets: EdgeInsets.symmetric(horizontal: 24),
              ),
              labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  GoogleFonts.poppins(fontWeight: FontWeight.w400),
              tabs: const [
                Tab(text: 'Movies'),
                Tab(text: 'Tv Shows'),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            MovieTab(),
            TvTab(),
          ],
        ),
      ),
    );
  }
}
