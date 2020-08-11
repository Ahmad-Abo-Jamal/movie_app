part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final int chosenTheme;
  ChangeTheme(this.chosenTheme);
}
