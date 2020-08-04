part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  final List<Result> movies;
  final MovieDetails movie;
  final int currentPage;
  final String criteria;
  const MoviesState({this.movies, this.movie, this.currentPage, this.criteria});
}

class MoviesInitial extends MoviesState {
  MoviesInitial() : super(movies: [], currentPage: 1);
  @override
  List<Object> get props => [];
}

class MoviesLoading extends MoviesState {
  const MoviesLoading(
      {int currentPage,
      String criteria,
      List<Result> movies,
      MovieDetails movie})
      : super(
            currentPage: currentPage,
            criteria: criteria,
            movies: movies,
            movie: movie);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MoviesLoaded extends MoviesState {
  bool reachedEnd = false;

  MoviesLoaded(
      {List<Result> movies,
      MovieDetails movie,
      this.reachedEnd,
      String criteria,
      int currentPage})
      : super(
            movies: movies,
            movie: movie,
            currentPage: currentPage,
            criteria: criteria);
  @override
  // TODO: implement props
  List<Object> get props => [movies];
}

class MoviesError extends MoviesState {
  final String message;
  const MoviesError({this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
