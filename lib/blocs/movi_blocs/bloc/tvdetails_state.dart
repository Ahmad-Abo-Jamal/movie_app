part of 'tvdetails_bloc.dart';

abstract class TvDetailsState extends Equatable {
  final List<Season> seasons;
  final List<TvResult> similar;
  final TvDetails tvShow;
  const TvDetailsState({
    this.seasons,
    this.similar,
    this.tvShow,
  });
}

class TvDetailsInitial extends TvDetailsState {
  TvDetailsInitial() : super(seasons: [], similar: []);
  @override
  List<Object> get props => [];
}

class TvDetailsLoading extends TvDetailsState {
  const TvDetailsLoading(
      {List<Season> seasons, TvDetails tvShow, List<TvResult> similar})
      : super(seasons: seasons, tvShow: tvShow, similar: similar);
  @override
  List<Object> get props => [seasons, similar, tvShow];
}

class TvDetailsLoaded extends TvDetailsState {
  TvDetailsLoaded(
      {List<Season> seasons, TvDetails tvShow, List<TvResult> similar})
      : super(
          seasons: seasons,
          similar: similar,
          tvShow: tvShow,
        );
  @override
  List<Object> get props => [seasons, similar, tvShow];
}

class TvDetailsError extends TvDetailsState {
  final String message;
  const TvDetailsError({this.message});
  @override
  List<Object> get props => [message];
}
