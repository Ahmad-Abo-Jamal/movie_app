part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  final List<Result> movies;
  final List<Genre> genres;
  final int currentPage;
  final String criteria;
  const MoviesState({
    this.movies,
    this.genres,
    this.currentPage,
    this.criteria,
  });
}

class MoviesInitial extends MoviesState {
  MoviesInitial() : super(movies: [], currentPage: 1, genres: []);
  @override
  List<Object> get props => [];
}

class MoviesLoading extends MoviesState {
  const MoviesLoading({
    int currentPage,
    String criteria,
    List<Genre> genres,
    List<Result> similarMovies,
    List<Result> movies,
  }) : super(
            currentPage: currentPage,
            criteria: criteria,
            movies: movies,
            genres: genres);
  @override
  List<Object> get props => [];
}

class MoviesLoaded extends MoviesState {
  bool reachedEnd = false;

  MoviesLoaded(
      {List<Result> movies,
      List<Genre> genres,
      List<Result> similarMovies,
      this.reachedEnd,
      String criteria,
      int currentPage})
      : super(
            movies: movies,
            genres: genres,
            currentPage: currentPage,
            criteria: criteria);
  @override
  List<Object> get props => [movies];
}

class MoviesError extends MoviesState {
  final String message;
  const MoviesError({this.message});
  @override
  List<Object> get props => [message];
}
