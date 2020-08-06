import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:switch_theme/core/api/movies_api.dart';
import 'package:switch_theme/core/models/movie_list_model.dart';
import 'package:switch_theme/core/models/movie_model.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial());
  final logger = Logger();
  final _api = MoviesApi();

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is GetMovieById) {
      yield* _mapGetMovieById(event.id);
    } else if (event is GetSimilarMovies) {
      yield* _mapGetSimilarMoviesToState(event.id);
    }
  }

  void getMovieById(int id) {
    this.add(GetMovieById(id: id));
  }

  Stream<DetailsState> _mapGetSimilarMoviesToState(int id) async* {
    try {
      yield DetailsLoading(
          similarMovies: state.similarMovies, movie: state.movie);
      MovieList response = await _api.getSimilarMovies(id);
      logger.d(response);
      yield DetailsLoaded(
        similarMovies: response.results,
        movie: state.movie,
      );
    } catch (e) {
      logger.e(e);
      yield DetailsError(message: e.toString());
    }
  }

  void getSimilarMovies(int id) {
    this.add(GetSimilarMovies(id: id));
  }

  Stream<DetailsState> _mapGetMovieById(int id) async* {
    try {
      yield DetailsLoading(
        similarMovies: state.similarMovies,
        movie: state.movie,
      );
      MovieDetails response = await _api.getMovieById(id);
      logger.d(response);
      yield DetailsLoaded(movie: response, similarMovies: state.similarMovies);
    } catch (e) {
      logger.e(e);
      yield DetailsError(message: e.toString());
    }
  }
}
