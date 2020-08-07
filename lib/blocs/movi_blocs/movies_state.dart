part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  final List<Result> movies;

  final int currentPage;
  final String criteria;
  const MoviesState({
    this.movies,
    this.currentPage,
    this.criteria,
  });
}

class MoviesInitial extends MoviesState {
  MoviesInitial() : super(movies: [], currentPage: 1);
  @override
  List<Object> get props => [];
}

class MoviesLoading extends MoviesState {
  const MoviesLoading({
    int currentPage,
    String criteria,
    List<Result> similarMovies,
    List<Result> movies,
  }) : super(
          currentPage: currentPage,
          criteria: criteria,
          movies: movies,
        );
  @override
  List<Object> get props => [];
}

class MoviesLoaded extends MoviesState {
  bool reachedEnd = false;

  MoviesLoaded(
      {List<Result> movies,
      List<Result> similarMovies,
      this.reachedEnd,
      String criteria,
      int currentPage})
      : super(movies: movies, currentPage: currentPage, criteria: criteria);
  @override
  List<Object> get props => [movies];
}

class MoviesError extends MoviesState {
  final String message;
  const MoviesError({this.message});
  @override
  List<Object> get props => [message];
}
