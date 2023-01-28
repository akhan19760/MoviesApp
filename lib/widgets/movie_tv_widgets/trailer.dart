import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Trailer extends StatefulWidget {
  Trailer({Key? key, required this.videoId}) : super(key: key);
  final String videoId;

  @override
  _TrailerState createState() => _TrailerState();
}

class _TrailerState extends State<Trailer> {
  late YoutubePlayerController? _ytbPlayerController =
      YoutubePlayerController.fromVideoId(
    videoId: widget.videoId,
    params: const YoutubePlayerParams(
      showFullscreenButton: true,
      enableCaption: true,
      mute: true,
      loop: true,
    ),
  );

  @override
  void initState() {
    super.initState();

    _setOrientation([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();

    _setOrientation([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _ytbPlayerController?.close();
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: _buildYtbView(),
        ));
  }

  _buildYtbView() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: _ytbPlayerController != null
          ? YoutubePlayer(controller: _ytbPlayerController)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
