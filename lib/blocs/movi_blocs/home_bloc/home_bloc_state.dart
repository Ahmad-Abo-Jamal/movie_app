part of 'home_bloc_bloc.dart';

abstract class HomeState extends Equatable {
  final int currentPage;
  final List<Result> trendings;
  final MovieDetails latest;
  const HomeState({
    this.currentPage,
    this.latest,
    this.trendings,
  });
}

class HomeInitial extends HomeState {
  HomeInitial() : super(currentPage: 1, trendings: []);
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  const HomeLoaded(
      {int currentPage, List<Result> trendings, MovieDetails latest})
      : assert(trendings != null),
        super(latest: latest, currentPage: currentPage, trendings: trendings);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomeError extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading(
      {List<Result> trendings, int currentPage, MovieDetails latest})
      : super(trendings: trendings, currentPage: currentPage, latest: latest);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
