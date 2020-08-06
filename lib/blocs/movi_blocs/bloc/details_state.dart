part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  final List<Result> similarMovies;
  final MovieDetails movie;
  const DetailsState({
    this.similarMovies,
    this.movie,
  });
}

class DetailsInitial extends DetailsState {
  DetailsInitial() : super(similarMovies: []);
  @override
  List<Object> get props => [];
}

class DetailsLoading extends DetailsState {
  const DetailsLoading({List<Result> similarMovies, MovieDetails movie})
      : super(similarMovies: similarMovies, movie: movie);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DetailsLoaded extends DetailsState {
  bool reachedEnd = false;

  DetailsLoaded({
    List<Result> similarMovies,
    MovieDetails movie,
  }) : super(
          similarMovies: similarMovies,
          movie: movie,
        );
  @override
  // TODO: implement props
  List<Object> get props => [similarMovies, movie];
}

class DetailsError extends DetailsState {
  final String message;
  const DetailsError({this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
