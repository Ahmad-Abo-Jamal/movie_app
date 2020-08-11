import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:switch_theme/blocs/movi_blocs/movies_bloc.dart';
import 'package:switch_theme/blocs/movi_blocs/tv_bloc/tv_bloc.dart';
import 'package:switch_theme/screens/movies/detail_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:switch_theme/screens/tv_shows/tv_details_screen.dart';
import 'package:switch_theme/shared/error.dart';

class TvListScreen extends StatefulWidget {
  static const imgUrl = "https://image.tmdb.org/t/p/w500/";
  TvListScreen({
    Key key,
  }) : super(key: key);

  @override
  _TvListScreenState createState() => _TvListScreenState();
}

class _TvListScreenState extends State<TvListScreen> {
  int _currentIndex = 0;
  final _scrollController = ScrollController();
  TvBloc _mbloc;
  @override
  void initState() {
    super.initState();
    _mbloc = BlocProvider.of<TvBloc>(context);
    _mbloc.getTvByCriteria("airing_today");
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvBloc, TvState>(builder: (context, state) {
        return Center(child: _render(context, state));
      }),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        unselectedItemColor: Theme.of(context).backgroundColor,
        selectedItemColor: Theme.of(context).indicatorColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          final table = ["airing_today", "on_the_air", "top_rated", "popular"];
          _mbloc.getTvByCriteria(table[index]);
          if (this.mounted)
            setState(() {
              _currentIndex = index;
            });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.calendarToday), title: Text("On Air Today")),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.satelliteUplink), title: Text("On Air")),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.starBoxMultiple), title: Text("Top rated")),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.star), title: Text("popular")),
        ]);
  }

  Widget _render(BuildContext context, TvState state) {
    if (state is TvLoading || state is TvInitial) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).backgroundColor,
        ),
      );
    } else if (state is TvError) {
      return ErrorUi(
        message: state.message,
      );
    } else if (state is TvLoaded) {
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
                  return i >= state?.tvList?.length
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(child: LinearProgressIndicator()),
                        )
                      : _tvTile(state, i);
                }),
          ));
    }
  }

  ListTile _tvTile(TvLoaded state, int i) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (_) => TvDetailsScreen(
                  result: state?.tvList[i],
                )));
      },
      leading: Hero(
        tag: state?.tvList[i]?.id,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: FadeInImage.assetNetwork(
              imageErrorBuilder: (_, __, ___) {
                return Image.asset("assets/no-image.png");
              },
              placeholder: "assets/371.gif",
              image:
                  "${TvListScreen.imgUrl}${state?.tvList[i]?.backdrop_path ?? ""}"),
        ),
      ),
      title: Text(state?.tvList[i]?.name?.toString(),
          style: TextStyle(color: Theme.of(context).backgroundColor)),
      trailing: CircularPercentIndicator(
        center: Text(state?.tvList[i]?.vote_average.toString(),
            style: TextStyle(color: Theme.of(context).backgroundColor)),
        radius: 40.0,
        progressColor: Theme.of(context).indicatorColor,
        backgroundColor: Theme.of(context).cardColor,
        percent: state?.tvList[i]?.vote_average / 10 ?? 0,
      ),
    );
  }

  bool _handleNotification(ScrollNotification notif, BuildContext context) {
    if (notif is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      BlocProvider.of<TvBloc>(context).getNextPage();
    }
  }

  int _calculate(TvLoaded state) {
    return state.reachedEnd ? state?.tvList?.length : state?.tvList?.length + 1;
  }
}
