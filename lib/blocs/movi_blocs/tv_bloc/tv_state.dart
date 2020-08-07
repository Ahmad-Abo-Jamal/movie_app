part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  final List<TvResult> tvList;
  final bool reachedEnd;
  final int currentPage;
  final String criteria;
  const TvState(
      {this.tvList, this.reachedEnd = false, this.currentPage, this.criteria});
}

class TvInitial extends TvState {
  TvInitial()
      : super(
            tvList: <TvResult>[],
            currentPage: 1,
            reachedEnd: false,
            criteria: "airing_today");
  @override
  List<Object> get props => [];
}

class TvLoading extends TvState {
  const TvLoading(
      {int currentPage,
      String criteria,
      List<TvResult> tvList,
      TvDetails movie})
      : super(
          currentPage: currentPage,
          criteria: criteria,
          tvList: tvList,
        );
  @override
  List<Object> get props => [];
}

class TvLoaded extends TvState {
  final bool reachedEnd;

  TvLoaded(
      {List<TvResult> tvList,
      this.reachedEnd = false,
      String criteria,
      int currentPage})
      : super(tvList: tvList, currentPage: currentPage, criteria: criteria);
  @override
  List<Object> get props => [tvList];
}

class TvError extends TvState {
  final String message;
  const TvError({this.message});
  @override
  List<Object> get props => [message];
}
