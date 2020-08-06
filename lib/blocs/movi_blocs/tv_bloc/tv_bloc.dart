import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:switch_theme/core/api/tv_repo.dart';
import 'package:switch_theme/core/models/tv_list.dart';
import 'package:switch_theme/core/models/tv_model.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  final logger = Logger();

  TvBloc() : super(TvInitial());
  final _api = TvApi();

  void getTvByCriteria(String criteria) {
    this.add(GetTvByCriteria(criteria: criteria));
  }

  void getNextPage() {
    logger.d(state.currentPage);
    this.add(GetNextTvPage(
        criteria: state.criteria, nextPage: state.currentPage + 1));
  }

  @override
  Stream<TvState> mapEventToState(
    TvEvent event,
  ) async* {
    if (event is GetTvByCriteria) {
      yield* _mapGetTvByCriteriaToState(event);
    } else if (event is GetNextTvPage) {
      yield* _mapGetNextPage(event, event.nextPage);
    }
  }

  Stream<TvState> _mapGetTvByCriteriaToState(event) async* {
    try {
      yield TvLoading(
          criteria: event.criteria, currentPage: 1, tvList: state.tvList);
      TvList response = await _api.getNextTvPage(event.criteria, 1);
      logger.d(response);
      yield TvLoaded(
          tvList: response.results,
          reachedEnd: false,
          currentPage: 1,
          criteria: state.criteria);
    } on NoNextPageException catch (_) {
      yield TvLoaded(tvList: state.tvList, reachedEnd: true);
    } catch (e) {
      logger.e(e);
      yield TvError(message: e.toString());
    }
  }

  Stream<TvState> _mapGetNextPage(event, int page) async* {
    try {
      TvList response = await _api.getNextTvPage(event.criteria, page);

      yield TvLoaded(
          tvList: state.tvList + response.results,
          reachedEnd: false,
          criteria: state.criteria,
          currentPage: state.currentPage + 1);
    } on NoNextPageException catch (_) {
      yield TvLoaded(
          tvList: state.tvList, reachedEnd: true, criteria: event.criteria);
    } catch (e) {
      logger.e(e);
      yield TvError(message: e.toString());
    }
  }
}
