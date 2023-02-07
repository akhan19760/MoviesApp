import 'package:flutter/material.dart';
import 'package:movies_app/view/auth/login_page.dart';
import 'package:movies_app/widgets/common_widgets/poppins_text.dart';

class PopcornIcon extends StatefulWidget {
  @override
  _PopcornIconState createState() => _PopcornIconState();
}

class _PopcornIconState extends State<PopcornIcon>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    // Define the animation curve
    final curve = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    );

    _controller!.repeat();

    // Create the scale animation using the animation controller and curve
    _scaleAnimation = Tween<double>(begin: 0, end: 0.3).animate(curve);

    // Add a listener to the animation controller to listen for the completed event
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to the next page when the animation is complete
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });

    // Start the animation
    _controller!.forward();
  }

  @override
  void dispose() {
    // Dispose of the animation controller when the widget is disposed
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: _scaleAnimation!,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/popcorn.png',
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: poppinsText(
                    text: 'PopcornFlix',
                    size: 60.0,
                    fontBold: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ));
  }
}
