import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:switch_theme/Theme/bloc/theme_bloc.dart';
import 'package:switch_theme/blocs/bloc/movies_bloc.dart';
import 'package:switch_theme/core/models/movie_list_model.dart';
import 'package:switch_theme/shared/theme_switcher.dart';
import "../core/models/movie_model.dart";
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
    // TODO: implement initState
    super.initState();
    BlocProvider.of<MoviesBloc>(context).getMovieById(widget.result.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[MySwitch(bloc: BlocProvider.of<ThemeBloc>(context))],
        centerTitle: true,
        title: Text("detail screen"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                    tag: widget?.result?.id,
                    child: Image.network(
                        "${ListScreen.imgUrl}${widget?.result?.backdrop_path}")),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Text(widget?.result?.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30.0))),
              ),
              SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {},
                  starCount: 5,
                  rating: (widget?.result?.vote_average / 10) * 5,
                  size: 40.0,
                  isReadOnly: true,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 0.0),
              SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget?.result?.overview,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                builder: (context, state) {
                  return _render(context, state);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _render(BuildContext context, MoviesState state) {
    if (state is MoviesLoaded)
      return Container(
        width: MediaQuery.of(context).size.width * 0.99,
        height: MediaQuery.of(context).size.height * 0.07,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state?.movie?.genres?.length ?? 0,
          itemBuilder: (_, i) =>
              Chip(label: Text(state?.movie?.genres[i]?.name ?? "")),
        ),
      );
    else if (state is MoviesLoading) {
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
}
