import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:switch_theme/core/api/movies_api.dart';
import "../../../core/models/movie_list_model.dart";
part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());
  final logger = Logger();
  final _api = MoviesApi();
  void getTrending() {
    this.add(GetTrending(nextPage: state.currentPage));
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetTrending) {
      yield* _mapGetTrending(event);
    }
  }

  Stream<HomeState> _mapGetTrending(GetTrending event) async* {
    try {
      MovieList response = await _api.getTrending(event.nextPage, event.dw);
      yield HomeLoaded(
          trendings: state.trendings + response.results,
          // reachedEnd: false,
          currentPage: state.currentPage + 1);
    } on NoNextPageException catch (_) {
      yield HomeLoaded(trendings: state.trendings);
    } catch (e) {
      logger.e(e);
      yield HomeError();
    }
  }
}
