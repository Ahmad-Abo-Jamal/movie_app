import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:switch_theme/Theme/themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial());
  void switchTheme() {
    this.add(ChangeTheme(state.themeData == AppTheme.DarkTheme
        ? AppTheme.LightTheme
        : AppTheme.DarkTheme));
  }

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ChangeTheme) {
      yield ThemeChosen(appTheme: event.chosenTheme);
    }
  }
}
