import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:switch_theme/core/api/tv_repo.dart';
import 'package:switch_theme/core/models/tv_list.dart';
import 'package:switch_theme/shared/exceptions.dart';

part 'home_tv_event.dart';
part 'home_tv_state.dart';

class HomeTvBloc extends Bloc<HomeTvEvent, HomeTvState> {
  HomeTvBloc() : super(HomeTvInitial());
  final logger = Logger();

  void getTvShows({String dw}) {
    this.add(GetTvShows(dw: dw ?? "week"));
  }

  final _tApi = TvApi();
  @override
  Stream<HomeTvState> mapEventToState(
    HomeTvEvent event,
  ) async* {
    if (event is GetTvShows) {
      yield* _mapGetTvShowsToState(event);
    }
  }

  Stream<HomeTvState> _mapGetTvShowsToState(GetTvShows event) async* {
    try {
      yield HomeLoadingTv();
      TvList response = await _tApi.getTrending(event.dw);
      yield HomeTvLoaded(
        tvShows: response.results,
      );
    } catch (e) {
      logger.e(e);
      yield HomeTvError();
    }
  }
}
