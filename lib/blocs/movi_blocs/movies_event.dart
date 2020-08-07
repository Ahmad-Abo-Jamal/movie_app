part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
}

class GetMoviesByCriteria extends MoviesEvent {
  final String criteria;

  GetMoviesByCriteria({this.criteria});
  @override
  List<Object> get props => [criteria];
}

class GetNextPage extends MoviesEvent {
  final int nextPage;
  final String criteria;
  GetNextPage({this.nextPage, this.criteria});

  @override
  List<Object> get props => [criteria, nextPage];
}
