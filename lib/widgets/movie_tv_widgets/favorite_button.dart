import 'package:flutter/material.dart';
import 'package:mobile_app_project/model/movie_model.dart';
import 'package:mobile_app_project/model/tv_model.dart';
import 'package:mobile_app_project/network/network.dart';
import 'package:mobile_app_project/providers/movie_provider.dart';
import 'package:mobile_app_project/providers/user_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({super.key, this.movie, this.tv});

  Movie? movie;
  Tv? tv;
  Network network = Network();

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext) {
    return widget.movie != null
        ? IconButton(
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
              context
                      .read<UserProvider>()
                      .user
                      .favMovies
                      .contains(widget.movie!.id)
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
              await widget.network.addToFavoriteMovies(
                  context.read<UserProvider>().user.favMovies);
              setState(() {});
            })
        : IconButton(
            icon: context
                    .watch<UserProvider>()
                    .user
                    .favTvs
                    .contains(widget.tv!.id)
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(
                    Icons.favorite_outline,
                    color: Colors.white,
                  ),
            onPressed: () async {
              context.read<UserProvider>().user.favTvs.contains(widget.tv!.id)
                  ? context
                      .read<UserProvider>()
                      .user
                      .favTvs
                      .remove(widget.tv!.id)
                  : context.read<UserProvider>().user.favTvs.add(widget.tv!.id);
              print(context.read<UserProvider>().user.favTvs);
              await widget.network
                  .addToFavoriteTvs(context.read<UserProvider>().user.favTvs);
              setState(() {});
            });
  }
}
