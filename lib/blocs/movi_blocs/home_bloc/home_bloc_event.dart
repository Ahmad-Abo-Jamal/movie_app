part of 'home_bloc_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetLatest extends HomeEvent {
  @override
  List<Object> get props => [];
}

class GetTrending extends HomeEvent {
  final String dw;

  GetTrending({
    this.dw,
  });

  @override
  List<Object> get props => [dw];
}
