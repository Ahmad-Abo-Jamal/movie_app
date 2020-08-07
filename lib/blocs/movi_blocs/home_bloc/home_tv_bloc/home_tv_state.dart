part of 'home_tv_bloc.dart';

abstract class HomeTvState extends Equatable {
  final List<TvResult> tvShows;

  const HomeTvState({
    this.tvShows,
  });
}

class HomeTvInitial extends HomeTvState {
  HomeTvInitial() : super(tvShows: []);
  @override
  List<Object> get props => [];
}

class HomeTvLoaded extends HomeTvState {
  const HomeTvLoaded({@required List<TvResult> tvShows})
      : assert(tvShows != null),
        super(tvShows: tvShows);
  @override
  List<Object> get props => [];
}

class HomeTvError extends HomeTvState {
  @override
  List<Object> get props => [];
}

class HomeLoadingTv extends HomeTvState {
  const HomeLoadingTv({List<TvResult> tvShows}) : super(tvShows: tvShows);
  @override
  List<Object> get props => [];
}
