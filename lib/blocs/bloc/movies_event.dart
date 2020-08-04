part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
}

class GetMovieById extends MoviesEvent {
  final int id;
  GetMovieById({this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class GetMoviesByCriteria extends MoviesEvent {
  final String criteria;

  GetMoviesByCriteria({this.criteria});
  @override
  // TODO: implement props
  List<Object> get props => [criteria];
}

class GetNextPage extends MoviesEvent {
  final int nextPage;
  final String criteria;
  GetNextPage({this.nextPage, this.criteria});

  @override
  // TODO: implement props
  List<Object> get props => [criteria, nextPage];
}
