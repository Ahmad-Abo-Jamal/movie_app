import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:switch_theme/Theme/bloc/theme_bloc.dart';
import 'package:switch_theme/blocs/auth_bloc/auth_bloc_bloc.dart';
import 'package:switch_theme/blocs/movi_blocs/bloc/details_bloc.dart';
import 'package:switch_theme/blocs/movi_blocs/bloc/tvdetails_bloc.dart';
import 'package:switch_theme/blocs/movi_blocs/tv_bloc/tv_bloc.dart';
import 'package:switch_theme/core/auth/authentification.dart';
import 'package:switch_theme/screens/movies/detail_screen.dart';
import 'package:switch_theme/screens/home_screen.dart';
import 'package:switch_theme/screens/movies/list_screen.dart';
import 'package:switch_theme/screens/login_screen.dart';
import 'package:switch_theme/screens/tv_shows/tv_list_screen.dart';
import 'package:switch_theme/shared/app_bar.dart';

import 'Theme/themes.dart';
import 'blocs/movi_blocs/home_bloc/home_bloc_bloc.dart';
import 'blocs/movi_blocs/home_bloc/home_tv_bloc/home_tv_bloc.dart';
import 'blocs/movi_blocs/movies_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) =>
              AuthBloc(userRepository: userRepository)..add(AuthStarted())),
      BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
      BlocProvider(
        create: (context) => DetailsBloc(),
      ),
      BlocProvider(
        create: (context) => TvdetailsBloc(),
      ),
    ],
    child: MyApp(userRepository: userRepository),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;
  const MyApp({
    Key key,
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: state.themeData,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (authState is AuthenticationInitial) {
                return SplashScreen();
              } else if (authState is AuthenticationSuccess) {
                return MultiBlocProvider(providers: [
                  BlocProvider(create: (context) => MoviesBloc()),
                  BlocProvider(
                    create: (context) => HomeBloc(),
                  ),
                  BlocProvider(
                    create: (context) => TvBloc(),
                  ),
                  BlocProvider(
                    create: (context) => HomeTvBloc(),
                  ),
                ], child: MainScreen());
              }
              return LoginScreen(
                userRepository: _userRepository,
              );
            },
          ));
    });
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 600.0,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.vpn_key,
              size: 100.0,
              color: Theme.of(context).backgroundColor,
            ),
            CircularProgressIndicator(
              strokeWidth: 10.0,
              backgroundColor: Theme.of(context).backgroundColor,
            )
          ],
        ),
      ),
    ));
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Movie App", tabController: _tabController),
      body: TabBarView(
          controller: _tabController,
          children: [HomeScreen(), ListScreen(), TvListScreen()]),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
