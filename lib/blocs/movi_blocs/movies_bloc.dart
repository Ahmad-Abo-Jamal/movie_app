import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:switch_theme/core/api/movies_api.dart';
import 'package:switch_theme/core/models/movie_list_model.dart';
import 'package:switch_theme/core/models/movie_model.dart';
import 'package:switch_theme/shared/exceptions.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final logger = Logger();

  MoviesBloc() : super(MoviesInitial());
  final _api = MoviesApi();

  void getMoviesByCriteria(String criteria) {
    this.add(GetMoviesByCriteria(criteria: criteria));
  }

  void getGenres() {
    this.add(GetGenres());
  }

  void getNextPage() {
    logger.d(state.currentPage);
    this.add(
        GetNextPage(criteria: state.criteria, nextPage: state.currentPage + 1));
  }

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if (event is GetMoviesByCriteria) {
      yield* _mapGetMoviesByCriteriaToState(event);
    } else if (event is GetNextPage) {
      yield* _mapGetNextPage(event, event.nextPage);
    } else if (event is GetGenres) {
      yield* _mapGetGenresToState();
    }
  }

  Stream<MoviesState> _mapGetGenresToState() async* {
    try {
      List<Genre> response = await _api.getGenres();
      logger.d(response);
      yield MoviesLoaded(
          movies: state.movies,
          currentPage: state.currentPage,
          criteria: state.criteria,
          genres: response);
    } catch (e) {
      yield MoviesError(message: "unable to get genres");
    }
  }

  Stream<MoviesState> _mapGetMoviesByCriteriaToState(event) async* {
    try {
      yield MoviesLoading(
          criteria: event.criteria, currentPage: 1, movies: state.movies);
      MovieList response = await _api.getNextMoviesPage(event.criteria, 1);
      logger.d(response);
      yield MoviesLoaded(
          movies: response.results,
          reachedEnd: false,
          currentPage: 1,
          criteria: state.criteria);
    } on NoNextPageException catch (_) {
      yield MoviesLoaded(movies: state.movies, reachedEnd: true);
    } catch (e) {
      logger.e(e);
      yield MoviesError(message: e.toString());
    }
  }

  Stream<MoviesState> _mapGetNextPage(event, int page) async* {
    try {
      MovieList response = await _api.getNextMoviesPage(event.criteria, page);

      yield MoviesLoaded(
          genres: state.genres,
          movies: state.movies + response.results,
          reachedEnd: false,
          criteria: state.criteria,
          currentPage: state.currentPage + 1);
    } on NoNextPageException catch (_) {
      yield MoviesLoaded(
          movies: state.movies, reachedEnd: true, criteria: event.criteria);
    } catch (e) {
      logger.e(e);
      yield MoviesError(message: e.toString());
    }
  }
}
