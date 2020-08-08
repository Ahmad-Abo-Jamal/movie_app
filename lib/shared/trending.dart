import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:switch_theme/blocs/movi_blocs/home_bloc/home_bloc_bloc.dart';
import 'package:switch_theme/core/models/movie_list_model.dart';
import 'package:switch_theme/core/models/movie_model.dart';
import 'package:switch_theme/core/models/tv_list.dart';
import 'package:switch_theme/core/models/tv_model.dart';
import 'package:switch_theme/screens/movies/detail_screen.dart';
import 'package:switch_theme/screens/tv_shows/tv_details_screen.dart';

class Trending extends StatelessWidget {
  const Trending({
    Key key,
    this.items,
    this.seasons,
    @required this.context,
    this.tvItems,
    @required this.imgUrl,
  })  : assert(items != null || tvItems != null || seasons != null),
        super(key: key);
  final List<Season> seasons;
  final List<Result> items;
  final List<TvResult> tvItems;
  final BuildContext context;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: ListView.builder(
            itemCount: items?.length ?? tvItems?.length ?? seasons?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: MyCard(
                    item: items?.elementAt(i),
                    tvItem: tvItems?.elementAt(i),
                    season: seasons?.elementAt(i),
                    imgUrl: imgUrl),
              );
            }),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key key,
    this.item,
    this.tvItem,
    this.season,
    this.movie,
    @required this.imgUrl,
  })  : assert(
            item != null || movie != null || tvItem != null || season != null),
        super(key: key);
  final MovieDetails movie;
  final Result item;
  final TvResult tvItem;
  final String imgUrl;
  final Season season;
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
          : () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => TvDetailsScreen(
                        result: tvItem,
                      )));
            },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 15,
              child: FadeInImage.assetNetwork(
                  placeholder: "assets/371.gif",
                  imageErrorBuilder: (_, o, st) {
                    return Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Image.asset(
                          "assets/no-image.png",
                        ));
                  },
                  image: imgUrl +
                      (item?.poster_path ??
                          movie?.poster_path ??
                          tvItem?.poster_path ??
                          season?.poster_path ??
                          "")),
            ),
            Flexible(
              flex: 2,
              child: season != null
                  ? Text(season?.air_date ?? "")
                  : SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {},
                      starCount: 5,
                      rating: ((item?.vote_average ??
                                  movie?.vote_average ??
                                  tvItem?.vote_average) /
                              10) *
                          5,
                      size: MediaQuery.of(context).size.width * 0.05,
                      isReadOnly: true,
                      color: Colors.green,
                      borderColor: Colors.green,
                      spacing: 0.0),
            ),
            Flexible(
              flex: 3,
              child: Text(
                item?.title ??
                    movie?.original_title ??
                    tvItem?.name ??
                    season?.name ??
                    "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
