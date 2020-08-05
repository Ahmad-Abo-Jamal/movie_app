import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:switch_theme/Theme/bloc/theme_bloc.dart';
import 'package:switch_theme/blocs/auth_bloc/auth_bloc_bloc.dart';
import 'package:switch_theme/blocs/bloc/bloc/home_bloc_bloc.dart';
import 'package:switch_theme/blocs/bloc/movies_bloc.dart';
import 'package:switch_theme/shared/confirm_dialog.dart';
import 'package:switch_theme/shared/theme_switcher.dart';

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
    BlocProvider.of<HomeBloc>(context).getTrending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(MdiIcons.logout),
          onPressed: () async {
            bool log = await showDialog<bool>(
                context: context,
                builder: (_) {
                  return ConfirmDialog(
                    message: "are you sure you wanna log out ? ",
                  );
                });
            if (log) {
              BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
            }
          },
        ),
        title: Text("Home"),
        actions: <Widget>[MySwitch(bloc: BlocProvider.of<ThemeBloc>(context))],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Container(
                child: _render(state),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _render(HomeState state) {
    if (state is HomeLoaded)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Trending", style: TextStyle(fontSize: 30.0)),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
                itemCount: state?.trendings?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FadeInImage.assetNetwork(
                              placeholder: "assets/371.gif",
                              imageErrorBuilder: (_, o, st) {
                                return Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    child: Image.asset(
                                      "assets/no-image.png",
                                    ));
                              },
                              image: imgUrl +
                                  (state?.trendings[i]?.backdrop_path ?? "")),
                          SizedBox(
                            height: 15.0,
                          ),
                          Expanded(
                            child: Text(
                              state?.trendings[i]?.title,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      );
    else if (state is HomeLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is HomeInitial) {
      return Center(
        child: Text("initial"),
      );
    }
    return Text("error");
  }
}
