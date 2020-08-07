part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();
}

class GetTvByCriteria extends TvEvent {
  final String criteria;
  GetTvByCriteria({this.criteria});
  @override
  List<Object> get props => [criteria];
}

class GetNextTvPage extends TvEvent {
  final int nextPage;
  final String criteria;
  GetNextTvPage({this.nextPage, this.criteria});

  @override
  List<Object> get props => [criteria, nextPage];
}
