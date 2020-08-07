import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'package:switch_theme/blocs/movi_blocs/home_bloc/home_bloc_bloc.dart';
import 'package:switch_theme/blocs/movi_blocs/home_bloc/home_tv_bloc/home_tv_bloc.dart';

import 'package:switch_theme/shared/trending.dart';

enum MTV { MOVIE, TV }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const imgUrl = "https://image.tmdb.org/t/p/w500/";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).getTrending(dw: "week");
    BlocProvider.of<HomeTvBloc>(context).getTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.2,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: buildListTile(context, MTV.MOVIE, "Movies Trending"),
              ),
              BlocBuilder<HomeBloc, HomeMoviesState>(builder: (context, state) {
                return Flexible(
                  flex: 1,
                  child: _render(state),
                );
              }),
              Flexible(
                  flex: 1,
                  child: buildListTile(context, MTV.TV, "Tv Shows Trending")),
              BlocBuilder<HomeTvBloc, HomeTvState>(
                builder: (context, state) {
                  return Flexible(flex: 1, child: _renderTv(state));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildListTile(BuildContext context, MTV mtv, String title) {
    return ListTile(
        trailing: PopupMenuButton(onSelected: (String value) {
          Logger().d(value);
          if (mtv == MTV.MOVIE)
            BlocProvider.of<HomeBloc>(context).getTrending(dw: value);
          if (mtv == MTV.TV)
            BlocProvider.of<HomeTvBloc>(context).getTvShows(dw: value);
        }, itemBuilder: (_) {
          return [
            PopupMenuItem(value: "day", child: Text("of the day")),
            PopupMenuItem(value: "week", child: Text("of the week")),
          ];
        }),
        leading: Text(title ?? "No Title", style: TextStyle(fontSize: 30.0)));
  }

  Widget _render(HomeMoviesState state) {
    if (state is HomeLoadedMovies)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Trending(
              items: state?.trendings ?? [],
              context: context,
              imgUrl: imgUrl,
            ),
          ),
        ],
      );
    else if (state is HomeLoadingMovies) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LinearProgressIndicator(),
        ),
      );
    } else if (state is HomeInitial) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text("error");
  }

  Widget _renderTv(HomeTvState state) {
    if (state is HomeTvLoaded)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Trending(
              tvItems: state?.tvShows ?? [],
              context: context,
              imgUrl: imgUrl,
            ),
          ),
        ],
      );
    else if (state is HomeLoadingTv) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LinearProgressIndicator(),
        ),
      );
    } else if (state is HomeInitial) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text("erro");
  }
}
