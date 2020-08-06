import 'package:flutter/material.dart';
import 'package:switch_theme/blocs/movi_blocs/home_bloc/home_bloc_bloc.dart';
import 'package:switch_theme/core/models/movie_list_model.dart';
import 'package:switch_theme/core/models/movie_model.dart';
import 'package:switch_theme/screens/detail_screen.dart';

class Trending extends StatelessWidget {
  const Trending({
    Key key,
    @required this.items,
    @required this.context,
    @required this.imgUrl,
  }) : super(key: key);

  final List<Result> items;
  final BuildContext context;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.22,
      child: ListView.builder(
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: MyCard(item: items[i], imgUrl: imgUrl),
            );
          }),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key key,
    this.item,
    this.movie,
    @required this.imgUrl,
  })  : assert(item != null || movie != null),
        super(key: key);
  final MovieDetails movie;
  final Result item;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DetailScreen(
                  result: item,
                )));
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FadeInImage.assetNetwork(
                placeholder: "assets/371.gif",
                imageErrorBuilder: (_, o, st) {
                  return Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Image.asset(
                        "assets/no-image.png",
                      ));
                },
                image: imgUrl +
                    (item?.backdrop_path ?? movie?.backdrop_path ?? "")),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Text(
                item?.title ?? movie?.original_title,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
