import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:switch_theme/Theme/bloc/theme_bloc.dart';
import 'package:switch_theme/blocs/movi_blocs/movies_bloc.dart';
import 'package:switch_theme/screens/movies/detail_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListScreen extends StatefulWidget {
  static const imgUrl = "https://image.tmdb.org/t/p/w500/";
  ListScreen({
    Key key,
  }) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int _currentIndex = 0;
  final _scrollController = ScrollController();
  MoviesBloc _mbloc;
  @override
  void initState() {
    super.initState();
    _mbloc = BlocProvider.of<MoviesBloc>(context);
    _mbloc.getMoviesByCriteria("now_playing");
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        return Center(child: _render(context, state));
      }),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentIndex,
        onTap: (index) {
          final table = ["now_playing", "popular", "top_rated", "upcoming"];
          _mbloc.getMoviesByCriteria(table[index]);
          if (this.mounted)
            setState(() {
              _currentIndex = index;
            });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.popcorn), title: Text("now playing")),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.star), title: Text("popular")),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.starBox), title: Text("top rated")),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.newBox), title: Text("upcoming")),
        ]);
  }

  Widget _render(BuildContext context, MoviesState state) {
    if (state is MoviesLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is MoviesError) {
      return Text(state.message);
    } else if (state is MoviesLoaded) {
      return NotificationListener<ScrollNotification>(
          onNotification: (notif) => _handleNotification(notif, context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.separated(
                controller: _scrollController,
                separatorBuilder: (_, i) {
                  return Divider(
                    color: Theme.of(context).accentColor,
                  );
                },
                itemCount: _calculate(state),
                itemBuilder: (_, i) {
                  return i >= state?.movies?.length
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(child: LinearProgressIndicator()),
                        )
                      : _movieTile(state, i);
                }),
          ));
    }
    return Center(
      child: FlatButton(
          color: Theme.of(context).backgroundColor,
          onPressed: () {
            _mbloc.getMoviesByCriteria("now_playing");
          },
          child: Text("Click To See Movies")),
    );
  }

  ListTile _movieTile(MoviesLoaded state, int i) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => DetailScreen(
                  result: state?.movies[i],
                )));
      },
      leading: Hero(
        tag: state?.movies[i]?.id,
        child: FadeInImage.assetNetwork(
            imageErrorBuilder: (_, __, ___) {
              return Image.asset("assets/no-image.png");
            },
            placeholder: "assets/371.gif",
            image:
                "${ListScreen.imgUrl}${state?.movies[i]?.backdrop_path ?? ""}"),
      ),
      title: Text(state?.movies[i]?.original_title?.toString()),
      trailing: CircularPercentIndicator(
        center: Text(state?.movies[i]?.vote_average.toString()),
        radius: 40.0,
        progressColor: Theme.of(context).accentColor,
        percent: state?.movies[i]?.vote_average / 10 ?? 0,
      ),
    );
  }

  bool _handleNotification(ScrollNotification notif, BuildContext context) {
    if (notif is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      BlocProvider.of<MoviesBloc>(context).getNextPage();
    }
  }

  int _calculate(MoviesLoaded state) {
    return state.reachedEnd ? state?.movies?.length : state?.movies?.length + 1;
  }
}
