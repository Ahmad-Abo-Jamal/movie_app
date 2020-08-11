import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:switch_theme/blocs/movi_blocs/bloc/details_bloc.dart';
import 'package:switch_theme/blocs/movi_blocs/bloc/tvdetails_bloc.dart';
import 'package:switch_theme/core/api/constants.dart';
import 'package:switch_theme/core/models/movie_list_model.dart';
import 'package:switch_theme/core/models/tv_list.dart';
import 'package:switch_theme/shared/app_bar.dart';
import 'package:switch_theme/shared/error.dart';
import 'package:switch_theme/shared/star_rating.dart';
import 'package:switch_theme/shared/trending.dart';
import "../../core/api/constants.dart";

class DetailScreen extends StatefulWidget {
  final Result result;
  const DetailScreen({Key key, this.result}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailsBloc>(context).getMovieById(widget.result.id);
    BlocProvider.of<DetailsBloc>(context).getSimilarMovies(widget.result.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Detail Screen",
        leading: false,
      ),
      body: buildSingleChildScrollView(context),
    );
  }

  Widget buildSingleChildScrollView(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: widget?.result?.id,
                  child: Image.network(
                    "$imgUrl${widget?.result?.backdrop_path}",
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Image.asset("assets/no-image.png");
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Text(widget?.result?.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Theme.of(context).backgroundColor))),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Text(widget?.result?.release_date,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Theme.of(context).backgroundColor))),
            ),
            Center(
              child: MyStarRating(
                voteAverage: widget?.result?.vote_average,
                size: 40.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                widget?.result?.overview,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 15.0, color: Theme.of(context).backgroundColor),
              ),
            ),
            BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                return _render(context, state);
              },
            )
          ]),
        )
      ],
    );
  }

  Widget _render(BuildContext context, DetailsState state) {
    final height = MediaQuery.of(context).size.height;
    if (state is DetailsLoaded)
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: state?.movie?.genres?.length == 0 ||
                    state?.movie?.genres == null
                ? Container(
                    height: 50.0,
                    child: Center(
                      child: Chip(
                        label: Text("no gender specified",
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor)),
                      ),
                    ),
                  )
                : Container(
                    height: 50.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state?.movie?.genres?.length ?? 0,
                      itemBuilder: (_, i) => Chip(
                          label: Text(state?.movie?.genres[i]?.name ?? "",
                              style: TextStyle(
                                  color: Theme.of(context).backgroundColor))),
                    ),
                  ),
          ),
          _renderSimilarMovies(state),
        ],
      );
    else if (state is DetailsLoading) {
      return Container(
        height: 50.0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LinearProgressIndicator(),
        ),
      );
    } else {
      return Chip(
          label: Text("No gender specified",
              style: TextStyle(color: Theme.of(context).backgroundColor)));
    }
  }

  Widget _renderSimilarMovies(DetailsState state) {
    if (state is DetailsLoaded) {
      return Column(
        children: <Widget>[
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(
                        "Budget : " +
                            (state?.movie?.budget?.toString() ??
                                "Not Mentioned") +
                            "\$",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).backgroundColor)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                    label: Text(
                        "Revenue : " +
                            (state?.movie?.revenue?.toString() ??
                                "Not Mentioned") +
                            "\$",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).backgroundColor)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Similar Movies",
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Theme.of(context).backgroundColor)),
            ),
          ),
          !(state?.similarMovies?.length == 0 || state?.similarMovies == null)
              ? Container(
                  height: 300,
                  child: Trending(
                      context: context,
                      imgUrl: imgUrl,
                      items: state?.similarMovies ?? []),
                )
              : Chip(
                  label: Text(
                    "No Similar Movies",
                    style: TextStyle(color: Theme.of(context).backgroundColor),
                  ),
                ),
        ],
      );
    } else if (state is DetailsLoading || state is DetailsInitial) {
      return Container(
          height: 50.0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LinearProgressIndicator(),
          ));
    } else if (state is DetailsError) {
      return ErrorUi();
    }
    return SizedBox();
  }
}
