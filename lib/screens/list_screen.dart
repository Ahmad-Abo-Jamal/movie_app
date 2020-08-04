import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:switch_theme/Theme/bloc/theme_bloc.dart';
import 'package:switch_theme/blocs/auth_bloc/auth_bloc_bloc.dart';
import 'package:switch_theme/blocs/bloc/movies_bloc.dart';
import 'package:switch_theme/screens/detail_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:switch_theme/shared/confirm_dialog.dart';
import 'package:switch_theme/shared/theme_switcher.dart';

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
  ThemeBloc _bloc;
  bool _switch = false;
  MoviesBloc _mbloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<ThemeBloc>(context);
    _mbloc = BlocProvider.of<MoviesBloc>(context);
  }

  @override
  void dispose() {
    _bloc.close();
    _mbloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        return Center(child: _render(context, state));
      }),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      actions: <Widget>[MySwitch(bloc: _bloc)],
      leading: IconButton(
          icon: Icon(MdiIcons.logout),
          onPressed: () async {
            var loggout = await showDialog<bool>(
                context: context,
                builder: (_) {
                  return ConfirmDialog(
                    message: "Are you sure you wanna logout ?",
                  );
                });
            if (loggout) {
              BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
            }
          }),
      title: Text(
        "Movie App",
      ),
      centerTitle: true,
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: (index) {
          final table = ["now_playing", "popular", "top_rated"];
          _mbloc.getMoviesByCriteria(table[index]);
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
        _mbloc.getMovieById(state?.movies[i].id);
        Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => DetailScreen(
                  result: state?.movies[i],
                )));
      },
      leading: Hero(
        tag: state?.movies[i]?.id,
        child: FadeInImage.assetNetwork(
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
