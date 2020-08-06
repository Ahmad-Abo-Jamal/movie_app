import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:switch_theme/core/models/tv_list.dart';
import 'package:switch_theme/core/models/tv_model.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

abstract class TvRepo {
  Future<TvDetails> getTvById(int id);
  Future<TvList> getNextTvPage(String criteria, int page);
  Future<TvList> getTrending(int page, String dw);
  Future<TvList> getSimilarTv(int id);
}

class TvApi implements TvRepo {
  final logger = Logger();

  String url(dynamic uri, {String language, int page}) =>
      "https://api.themoviedb.org/3/tv/$uri?api_key=$api_key&language=${language ?? "en-US"}&page=${page ?? 1}";

  @override
  Future<TvDetails> getTvById(int id) async {
    try {
      http.Response response = await http.get("${url(id)}");
      logger.i(response.statusCode);
      if (response.statusCode == 200) {
        return TvDetails.fromJson(response.body);
      }
      throw Exception("Failed to Load $id tv");
    } catch (e) {
      logger.e(e.toString());
      throw Exception("Faled to load $id tv");
    }
  }

  Future<TvList> getNextTvPage(String criteria, int page) async {
    logger.d(page);

    try {
      http.Response response = await http.get("${url(criteria, page: page)}");

      if (response.statusCode == 200) {
        if (page >= jsonDecode(response.body)["total_pages"]) {
          throw NoNextPageException();
        }
        return TvList.fromMap(jsonDecode(response.body));
      }
      throw Exception("Failed to Load $criteria tv");
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to load $criteria tv");
    }
  }

  Future<TvList> getTrending(int page, String dw) async {
    try {
      http.Response response = await http.get(
          "https://api.themoviedb.org/3/trending/tv/${dw}?api_key=${api_key}");

      if (response.statusCode == 200) {
        if (page >= jsonDecode(response.body)["total_pages"]) {
          throw NoNextPageException();
        }
        return TvList.fromMap(jsonDecode(response.body));
      }
      throw Exception("Failed to Load trending tv");
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to load trending tv");
    }
  }

  @override
  Future<TvList> getSimilarTv(int id) async {
    try {
      http.Response response = await http.get(
          "https://api.themoviedb.org/3/tv/${id}/similar?api_key=${api_key}");

      if (response.statusCode == 200) {
        return TvList.fromMap(jsonDecode(response.body));
      }
      throw Exception("Failed to Load trending movies");
    } catch (e) {
      logger.e(e);
      throw Exception("Failed to load trending movies");
    }
  }
}

class NoNextPageException implements Exception {}
