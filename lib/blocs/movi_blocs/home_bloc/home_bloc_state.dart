part of 'home_bloc_bloc.dart';

abstract class HomeMoviesState extends Equatable {
  final List<Result> trendings;
  final List<TvResult> tvShows;

  const HomeMoviesState({
    this.tvShows,
    this.trendings,
  });
}

class HomeInitial extends HomeMoviesState {
  HomeInitial() : super(trendings: [], tvShows: []);
  @override
  List<Object> get props => [];
}

class HomeLoadedMovies extends HomeMoviesState {
  const HomeLoadedMovies({List<Result> trendings, List<TvResult> tvShows})
      : assert(trendings != null || tvShows != null),
        super(trendings: trendings, tvShows: tvShows);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomeMovieError extends HomeMoviesState {
  @override
  List<Object> get props => [];
}

class HomeLoadingMovies extends HomeMoviesState {
  const HomeLoadingMovies({
    List<Result> trendings,
    int currentPage,
    MovieDetails latest,
  }) : super(
          trendings: trendings,
        );
  @override
  List<Object> get props => [];
}
