import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'package:switch_theme/blocs/movi_blocs/home_bloc/home_bloc_bloc.dart';

import 'package:switch_theme/shared/trending.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const imgUrl = "https://image.tmdb.org/t/p/w500/";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeBloc>(context).getTrending(dw: "week");
    BlocProvider.of<HomeBloc>(context).getLatest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: ListTile(
                      trailing: PopupMenuButton(onSelected: (String value) {
                        Logger().d(value);
                        BlocProvider.of<HomeBloc>(context)
                            .getTrending(dw: value);
                      }, itemBuilder: (_) {
                        return [
                          PopupMenuItem(
                              value: "day", child: Text("of the day")),
                          PopupMenuItem(
                              value: "week", child: Text("of the week")),
                        ];
                      }),
                      leading:
                          Text("Trending ", style: TextStyle(fontSize: 30.0))),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    child: _render(state),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _render(HomeState state) {
    Logger().d(state.latest);
    if (state is HomeLoaded)
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
          if (state.latest != null)
            Flexible(
              flex: 1,
              child: MyCard(
                imgUrl: imgUrl,
                movie: state?.latest,
              ),
            )
        ],
      );
    else if (state is HomeLoading) {
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
}
