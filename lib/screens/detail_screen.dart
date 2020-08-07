import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:switch_theme/blocs/movi_blocs/bloc/details_bloc.dart';
import 'package:switch_theme/blocs/movi_blocs/movies_bloc.dart';
import 'package:switch_theme/core/api/constants.dart';
import 'package:switch_theme/core/api/movies_api.dart';
import 'package:switch_theme/core/models/movie_list_model.dart';
import 'package:switch_theme/shared/app_bar.dart';
import 'package:switch_theme/shared/trending.dart';
import 'list_screen.dart';

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

  SingleChildScrollView buildSingleChildScrollView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 1.5,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: widget?.result?.id,
                  child: Image.network(
                    "${ListScreen.imgUrl}${widget?.result?.backdrop_path}",
                    errorBuilder: (_, __, ___) {
                      return Image.asset("assets/no-image.png");
                    },
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Text(widget?.result?.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30.0))),
              ),
            ),
            Flexible(
              flex: 1,
              child: SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {},
                  starCount: 5,
                  rating: (widget?.result?.vote_average / 10) * 5,
                  size: 40.0,
                  isReadOnly: true,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 0.0),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget?.result?.overview,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: BlocBuilder<DetailsBloc, DetailsState>(
                builder: (context, state) {
                  return _render(context, state);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _render(BuildContext context, DetailsState state) {
    if (state is DetailsLoaded)
      return Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state?.movie?.genres?.length ?? 0,
                itemBuilder: (_, i) =>
                    Chip(label: Text(state?.movie?.genres[i]?.name ?? "")),
              ),
            ),
          ),
          Flexible(flex: 4, child: _renderSimilarMovies(state)),
        ],
      );
    else if (state is DetailsLoading) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: LinearProgressIndicator(),
      );
    } else {
      return Card(
        child: Text("No gender specified"),
        color: Theme.of(context).backgroundColor,
      );
    }
  }

  Widget _renderSimilarMovies(DetailsState state) {
    if (state is DetailsLoaded) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Similar Movies", style: TextStyle(fontSize: 30.0)),
          ),
          state?.similarMovies?.length > 0
              ? Trending(
                  context: context,
                  imgUrl: imgUrl,
                  items: state?.similarMovies ?? [])
              : Chip(
                  label: Text("No Similar Movies"),
                ),
        ],
      );
    } else if (state is DetailsLoading) {
      return LinearProgressIndicator();
    }
    return SizedBox();
  }
}
