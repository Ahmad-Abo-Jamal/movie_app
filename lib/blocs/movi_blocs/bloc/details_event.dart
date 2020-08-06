part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();
}

class GetSimilarMovies extends DetailsEvent {
  final int id;
  GetSimilarMovies({
    this.id,
  });

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class GetMovieById extends DetailsEvent {
  final int id;
  GetMovieById({this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}
