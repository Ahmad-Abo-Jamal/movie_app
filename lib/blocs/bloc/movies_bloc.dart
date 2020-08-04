import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:switch_theme/core/api/movies_api.dart';
import 'package:switch_theme/core/models/movie_list_model.dart';
import 'package:switch_theme/core/models/movie_model.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final logger = Logger();

  MoviesBloc() : super(MoviesInitial());
  final _api = MoviesApi();
  void getMovieById(int id) {
    this.add(GetMovieById(id: id));
  }

  void getMoviesByCriteria(String criteria) {
    this.add(GetMoviesByCriteria(criteria: criteria));
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
    if (event is GetMovieById) {
      yield* _mapGetMovieById(event.id);
    } else if (event is GetMoviesByCriteria) {
      yield* _mapGetMoviesByCriteriaToState(event);
    } else if (event is GetNextPage) {
      yield* _mapGetNextPage(event, event.nextPage);
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
      logger.d(response);
      yield MoviesLoaded(
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

  Stream<MoviesState> _mapGetMovieById(int id) async* {
    try {
      yield MoviesLoading(
          movies: state.movies,
          movie: state.movie,
          criteria: state.criteria,
          currentPage: state.currentPage);
      MovieDetails response = await _api.getMovieById(id);
      logger.d(response);
      yield MoviesLoaded(
          movie: response,
          movies: state.movies,
          reachedEnd: false,
          criteria: state.criteria,
          currentPage: state.currentPage);
    } catch (e) {
      logger.e(e);
      yield MoviesError(message: e.toString());
    }
  }
}
