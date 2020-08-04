part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  final AppTheme themeData;
  ThemeState(this.themeData);
}

class ThemeInitial extends ThemeState {
  ThemeInitial() : super(AppTheme.DarkTheme);
}

class ThemeChosen extends ThemeState {
  ThemeChosen({AppTheme appTheme}) : super(appTheme);
}
