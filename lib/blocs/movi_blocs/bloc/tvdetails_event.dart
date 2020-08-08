part of 'tvdetails_bloc.dart';

abstract class TvDetailsEvent extends Equatable {
  const TvDetailsEvent();
}

class GetTvSeasons extends TvDetailsEvent {
  final int id;
  GetTvSeasons({
    this.id,
  });

  @override
  List<Object> get props => [id];
}

class GetTvById extends TvDetailsEvent {
  final int id;
  GetTvById({this.id});

  @override
  List<Object> get props => [id];
}

class GetTvSimilar extends TvDetailsEvent {
  final int id;
  GetTvSimilar({
    this.id,
  });

  @override
  List<Object> get props => [id];
}
