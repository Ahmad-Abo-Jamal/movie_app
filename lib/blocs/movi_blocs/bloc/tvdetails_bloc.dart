import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:switch_theme/blocs/movi_blocs/bloc/details_bloc.dart';
import 'package:switch_theme/core/api/tv_repo.dart';
import 'package:switch_theme/core/models/tv_list.dart';
import 'package:switch_theme/core/models/tv_model.dart';

part 'tvdetails_event.dart';
part 'tvdetails_state.dart';

class TvdetailsBloc extends Bloc<TvDetailsEvent, TvDetailsState> {
  TvdetailsBloc() : super(TvDetailsInitial());
  final logger = Logger();
  void getTvById(int id) {
    this.add(GetTvById(id: id));
  }

  void getSimilarTv(int id) {
    this.add(GetTvSimilar(id: id));
  }

  final _api = TvApi();
  void getSeasons(int id) {
    this.add(GetTvSeasons(id: id));
  }

  @override
  Stream<TvDetailsState> mapEventToState(
    TvDetailsEvent event,
  ) async* {
    if (event is GetTvById) {
      yield* _mapGetTvById(event.id);
    } else if (event is GetTvSimilar) {
      yield* _mapGetSimilarTvToState(event.id);
    }
  }

  Stream<TvDetailsState> _mapGetSimilarTvToState(int id) async* {
    try {
      yield TvDetailsLoading(similar: state.similar, tvShow: state.tvShow);
      TvList response = await _api.getSimilarTv(id);
      logger.d(response);
      yield TvDetailsLoaded(
        similar: response.results,
        tvShow: state.tvShow,
      );
    } catch (e) {
      logger.e(e);
      yield TvDetailsError(message: e.toString());
    }
  }

  Stream<TvDetailsState> _mapGetTvById(int id) async* {
    try {
      yield TvDetailsLoading(
        similar: state.similar,
        seasons: state.seasons,
        tvShow: state.tvShow,
      );
      TvDetails response = await _api.getTvById(id);
      logger.d(response);
      yield TvDetailsLoaded(tvShow: response, similar: state.similar);
    } catch (e) {
      logger.e(e);
      yield TvDetailsError(message: e.toString());
    }
  }
}
