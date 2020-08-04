import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:switch_theme/Theme/bloc/theme_bloc.dart';
import 'package:switch_theme/blocs/auth_bloc/auth_bloc_bloc.dart';
import 'package:switch_theme/blocs/bloc/movies_bloc.dart';
import 'package:switch_theme/core/auth/authentification.dart';
import 'package:switch_theme/screens/list_screen.dart';
import 'package:switch_theme/screens/login_screen.dart';

import 'Theme/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository userRepository = UserRepository();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) =>
              AuthBloc(userRepository: userRepository)..add(AuthStarted())),
      BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(),
      ),
      BlocProvider(create: (context) => MoviesBloc()),
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
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return MaterialApp(
          title: 'Flutter Demo',
          theme: appTheme[state.themeData],
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (authState is AuthenticationInitial) {
                return SplashScreen();
              } else if (authState is AuthenticationSuccess) {
                return ListScreen();
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
      body: Center(child: Text('Splash Screen')),
    );
  }
}
