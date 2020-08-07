import 'package:flutter/material.dart';
import 'package:switch_theme/blocs/movi_blocs/home_bloc/home_bloc_bloc.dart';
import 'package:switch_theme/core/models/movie_list_model.dart';
import 'package:switch_theme/core/models/movie_model.dart';
import 'package:switch_theme/core/models/tv_list.dart';
import 'package:switch_theme/screens/detail_screen.dart';

class Trending extends StatelessWidget {
  const Trending({
    Key key,
    this.items,
    @required this.context,
    this.tvItems,
    @required this.imgUrl,
  })  : assert(items != null || tvItems != null),
        super(key: key);

  final List<Result> items;
  final List<TvResult> tvItems;
  final BuildContext context;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
          itemCount: items?.length ?? tvItems?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: MyCard(
                  item: items?.elementAt(i),
                  tvItem: tvItems?.elementAt(i),
                  imgUrl: imgUrl),
            );
          }),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key key,
    this.item,
    this.tvItem,
    this.movie,
    @required this.imgUrl,
  })  : assert(item != null || movie != null || tvItem != null),
        super(key: key);
  final MovieDetails movie;
  final Result item;
  final TvResult tvItem;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item != null
          ? () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => DetailScreen(
                        result: item,
                      )));
            }
          : null,
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
                    (item?.backdrop_path ??
                        movie?.backdrop_path ??
                        tvItem?.backdrop_path ??
                        "")),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: Text(
                item?.title ?? movie?.original_title ?? tvItem?.name ?? "",
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
