part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  final ThemeData themeData;
  final int currentTheme;
  ThemeState(this.themeData, this.currentTheme);
}

class ThemeInitial extends ThemeState {
  ThemeInitial() : super(themeFromMap(themes[0]), 0);
}

class ThemeChosen extends ThemeState {
  ThemeChosen({int i}) : super(themeFromMap(themes[i]), i);
}
