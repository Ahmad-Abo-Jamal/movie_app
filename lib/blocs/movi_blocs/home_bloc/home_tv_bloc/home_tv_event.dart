part of 'home_tv_bloc.dart';

abstract class HomeTvEvent extends Equatable {
  const HomeTvEvent();
}

class GetTvShows extends HomeTvEvent {
  final String dw;
  GetTvShows({this.dw});

  @override
  List<Object> get props => [dw];
}
