import 'package:flutter/material.dart';
import 'package:movies_app/model/movie_model.dart';
import 'package:movies_app/network/network.dart';
import 'package:movies_app/providers/movie_provider.dart';
import 'package:movies_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({
    super.key,
    required this.movie,
  });

  Movie? movie;
  Network network = Network();

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext) {
    return IconButton(
        icon: context
                .watch<UserProvider>()
                .user
                .favMovies
                .contains(widget.movie!.id)
            ? Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : Icon(
                Icons.favorite_outline,
                color: Colors.white,
              ),
        onPressed: () async {
          context.read<UserProvider>().user.favMovies.contains(widget.movie!.id)
              ? context
                  .read<UserProvider>()
                  .user
                  .favMovies
                  .remove(widget.movie!.id)
              : context
                  .read<UserProvider>()
                  .user
                  .favMovies
                  .add(widget.movie!.id);
          print(context.read<UserProvider>().user.favMovies);
          await widget.network
              .addToFavoriteMovies(context.read<UserProvider>().user.favMovies);
          setState(() {});
        });
  }
}
