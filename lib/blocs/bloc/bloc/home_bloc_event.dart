part of 'home_bloc_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetTrending extends HomeEvent {
  final String dw;
  final int nextPage;
  GetTrending({
    this.dw,
    @required this.nextPage,
  });

  @override
  // TODO: implement props
  List<Object> get props => [dw, nextPage];
}
