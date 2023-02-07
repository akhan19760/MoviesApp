import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/view/movie_tvshows/trailer_page.dart';

class MoviePoster extends StatefulWidget {
  const MoviePoster(
      {Key? key,
      required this.image,
      required this.posterUrl,
      required this.showName})
      : super(key: key);
  final String imageUrl = 'https://image.tmdb.org/t/p/w500';

  final String? image;
  final String? posterUrl;
  final String? showName;

  @override
  State<MoviePoster> createState() => _MoviePosterState();
}

class _MoviePosterState extends State<MoviePoster> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 1,
      pageSnapping: true,
      itemBuilder: ((context, index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.network(
                widget.imageUrl + widget.image!,
                fit: BoxFit.fill,
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              Positioned(
                  left: 10,
                  bottom: 10,
                  child: Theme(
                    data: ThemeData(
                        canvasColor: Color(0xff246fdb).withOpacity(0.6)),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) => TrailerPage(
                                  videoUrl: widget.posterUrl,
                                  movieName: widget.showName,
                                )),
                          ),
                        );
                      },
                      child: Chip(
                          label: Text(
                            'Watch Trailer',
                            style: TextStyle(color: Colors.white),
                          ),
                          avatar: Icon(
                            Icons.play_circle,
                            color: Colors.white,
                          ),
                          backgroundColor: Color(0xff246fdb).withOpacity(0.5)),
                    ),
                  ))
            ],
          ),
        );
      }),
    );
  }
}
