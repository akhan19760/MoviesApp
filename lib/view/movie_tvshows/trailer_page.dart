import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_project/widgets/common_widgets/back_button.dart';
import 'package:mobile_app_project/widgets/movie_tv_widgets/trailer.dart';

class TrailerPage extends StatefulWidget {
  const TrailerPage({Key? key, required this.videoUrl, required this.movieName})
      : super(key: key);

  final String? videoUrl;
  final String? movieName;

  @override
  State<TrailerPage> createState() => _TrailerPageState();
}

class _TrailerPageState extends State<TrailerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.movieName! + ' Trailer'),
        leading: backButton(),
        backgroundColor: Color(0xff246fdb),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.black,
            child: Center(
              child: Trailer(
                videoId: widget.videoUrl!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
