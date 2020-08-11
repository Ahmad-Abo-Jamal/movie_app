import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'package:switch_theme/blocs/movi_blocs/home_bloc/home_bloc_bloc.dart';
import 'package:switch_theme/blocs/movi_blocs/home_bloc/home_tv_bloc/home_tv_bloc.dart';
import 'package:switch_theme/blocs/movi_blocs/movies_bloc.dart';
import 'package:switch_theme/core/api/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:switch_theme/shared/error.dart';

import 'package:switch_theme/shared/trending.dart';

enum MTV { MOVIE, TV }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).getTrending(dw: "week");
    BlocProvider.of<HomeTvBloc>(context).getTvShows();
    BlocProvider.of<MoviesBloc>(context).getMoviesByCriteria("popular");
    BlocProvider.of<MoviesBloc>(context).getGenres();
  }

  Widget _renderTopHome(MoviesState state) {
    if (state is MoviesLoading || state is MoviesInitial) {
      return Container(
        height: 250,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).backgroundColor,
          ),
        ),
      );
    } else if (state is MoviesLoaded) {
      return Column(
        children: <Widget>[
          if (state?.genres != null)
            if (state?.genres.length > 0)
              Container(
                height: 50,
                child: ListView.builder(
                    itemCount: state?.genres?.length,
                    itemBuilder: (_, i) {
                      print(state?.genres);
                      return Chip(label: Text(state?.genres[i]?.name));
                    }),
              ),
          Container(
            height: 250,
            color: Colors.transparent,
            child: PageView.builder(
                itemCount: state?.movies?.length ~/ 3,
                controller: controller,
                itemBuilder: (_, i) {
                  return Card(
                    color: Colors.transparent,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  imgUrl + state?.movies[i]?.backdrop_path,
                                ))),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.black45,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                state?.movies[i].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Theme.of(context).backgroundColor),
                              ),
                            ),
                          ),
                        )),
                  );
                }),
          ),
          SizedBox(
            height: 10.0,
          ),
          SmoothPageIndicator(
              effect: SwapEffect(
                  dotHeight: 10.0,
                  dotWidth: 10.0,
                  dotColor: Theme.of(context).backgroundColor,
                  activeDotColor: Theme.of(context).indicatorColor),
              controller: controller,
              count: state?.movies?.length ~/ 3)
        ],
      );
    } else if (state is MoviesError)
      return Center(
        child: ErrorUi(),
      );

    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverList(
          delegate: SliverChildListDelegate([
        BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            return _renderTopHome(state);
          },
        ),
        buildListTile(context, MTV.MOVIE, "Movies Trending"),
        BlocBuilder<HomeBloc, HomeMoviesState>(builder: (context, state) {
          return _render(state);
        }),
        buildListTile(context, MTV.TV, "Tv Shows Trending"),
        BlocBuilder<HomeTvBloc, HomeTvState>(
          builder: (context, state) {
            return _renderTv(state);
          },
        )
      ]))
    ]));
  }

  ListTile buildListTile(BuildContext context, MTV mtv, String title) {
    return ListTile(
        trailing: PopupMenuButton(
            color: Theme.of(context).backgroundColor,
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).backgroundColor,
            ),
            onSelected: (String value) {
              Logger().d(value);
              if (mtv == MTV.MOVIE)
                BlocProvider.of<HomeBloc>(context).getTrending(dw: value);
              if (mtv == MTV.TV)
                BlocProvider.of<HomeTvBloc>(context).getTvShows(dw: value);
            },
            itemBuilder: (_) {
              return [
                PopupMenuItem(value: "day", child: Text("of the day")),
                PopupMenuItem(value: "week", child: Text("of the week")),
              ];
            }),
        leading: Text(title ?? "No Title",
            style: TextStyle(
                fontSize: 30.0, color: Theme.of(context).backgroundColor)));
  }

  Widget _render(HomeMoviesState state) {
    if (state is HomeLoadedMovies)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 300.0,
            child: Trending(
              items: state?.trendings ?? [],
              context: context,
              imgUrl: imgUrl,
            ),
          ),
        ],
      );
    else if (state is HomeLoadingMovies) {
      return Container(
        height: 50,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LinearProgressIndicator(),
          ),
        ),
      );
    } else if (state is HomeInitial) {
      return Container(
        height: 50,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).backgroundColor,
          ),
        ),
      );
    } else if (state is HomeTvError) {
      return ErrorUi();
    }
  }

  Widget _renderTv(HomeTvState state) {
    if (state is HomeTvLoaded)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 300,
            child: Trending(
              tvItems: state?.tvShows ?? [],
              context: context,
              imgUrl: imgUrl,
            ),
          ),
        ],
      );
    else if (state is HomeLoadingTv || state is HomeTvInitial) {
      return Container(
        height: 50,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: LinearProgressIndicator(),
          ),
        ),
      );
    } else if (state is HomeTvError) {
      return ErrorUi();
    } else
      return SizedBox();
  }
}
