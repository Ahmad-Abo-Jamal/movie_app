part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  final List<TvResult> tvList;
  final bool reachedEnd;
  final int currentPage;
  final String criteria;
  const TvState(
      {this.tvList, this.reachedEnd = false, this.currentPage, this.criteria})
      : assert(tvList != null &&
            currentPage != null &&
            reachedEnd != null &&
            criteria != null);
}

class TvInitial extends TvState {
  TvInitial() : super(tvList: <TvResult>[], currentPage: 1, reachedEnd: false);
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
  // TODO: implement props
  List<Object> get props => [];
}

class TvLoaded extends TvState {
  bool reachedEnd = false;

  TvLoaded(
      {List<TvResult> tvList,
      this.reachedEnd,
      String criteria,
      int currentPage})
      : super(tvList: tvList, currentPage: currentPage, criteria: criteria);
  @override
  // TODO: implement props
  List<Object> get props => [tvList];
}

class TvError extends TvState {
  final String message;
  const TvError({this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
