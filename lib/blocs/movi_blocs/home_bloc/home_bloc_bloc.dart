import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:switch_theme/core/api/movies_api.dart';
import 'package:switch_theme/core/api/tv_repo.dart';
import 'package:switch_theme/core/models/movie_model.dart';
import 'package:switch_theme/core/models/tv_list.dart';
import 'package:switch_theme/shared/exceptions.dart';
import "../../../core/models/movie_list_model.dart";
part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeMoviesState> {
  HomeBloc() : super(HomeInitial());
  final logger = Logger();
  final _api = MoviesApi();

  void getTrending({String dw}) {
    this.add(GetTrending(dw: dw ?? "week"));
  }

  @override
  Stream<HomeMoviesState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetTrending) {
      yield* _mapGetTrending(event);
    }
  }

  Stream<HomeMoviesState> _mapGetTrending(GetTrending event) async* {
    try {
      List<TvResult> tvShows = state.tvShows;
      yield HomeLoadingMovies();
      MovieList response = await _api.getTrending(event.dw);
      yield HomeLoadedMovies(
        tvShows: tvShows,
        trendings: response.results,
        // reachedEnd: false,
      );
    } catch (e) {
      logger.e(e);
      yield HomeMovieError();
    }
  }
}
