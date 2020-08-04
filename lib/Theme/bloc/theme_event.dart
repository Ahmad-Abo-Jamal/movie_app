part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final AppTheme chosenTheme;
  ChangeTheme(this.chosenTheme);
}
