part of 'home_bloc_bloc.dart';

abstract class HomeState extends Equatable {
  final int currentPage;
  final List<Result> trendings;
  const HomeState({
    this.currentPage,
    this.trendings,
  });
}

class HomeInitial extends HomeState {
  HomeInitial() : super(currentPage: 1, trendings: []);
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  const HomeLoaded({int currentPage, List<Result> trendings})
      : assert(trendings != null),
        super(currentPage: currentPage, trendings: trendings);
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
  const HomeLoading({List<Result> trendings, int currentPage})
      : super(trendings: trendings, currentPage: currentPage);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
