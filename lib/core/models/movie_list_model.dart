import 'dart:convert';

import 'package:equatable/equatable.dart';

class MovieList extends Equatable {
  final int page;
  final List<Result> results;
  final int total_pages;
  final int total_results;
  MovieList({
    this.page,
    this.results,
    this.total_pages,
    this.total_results,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'results': results?.map((x) => x?.toMap())?.toList(),
      'total_pages': total_pages,
      'total_results': total_results,
    };
  }

  static MovieList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MovieList(
      page: map['page'],
      results: List<Result>.from(map['results']?.map((x) => Result.fromMap(x))),
      total_pages: map['total_pages'],
      total_results: map['total_results'],
    );
  }

  String toJson() => json.encode(toMap());

  static MovieList fromJson(String source) => fromMap(json.decode(source));

  @override
  List<Object> get props => [page, total_pages, total_results];
}

class Result extends Equatable {
  final String poster_path;
  final bool adult;
  final String overview;
  final String release_date;
  final List<int> genre_ids;
  final int id;
  final String original_title;
  final String original_language;
  final String title;
  final String backdrop_path;
  final num popularity;
  final int vote_count;
  final bool video;
  final num vote_average;
  Result({
    this.poster_path,
    this.adult,
    this.overview,
    this.release_date,
    this.genre_ids,
    this.id,
    this.original_title,
    this.original_language,
    this.title,
    this.backdrop_path,
    this.popularity,
    this.vote_count,
    this.video,
    this.vote_average,
  });

  Map<String, dynamic> toMap() {
    return {
      'poster_path': poster_path,
      'adult': adult,
      'overview': overview,
      'release_date': release_date,
      'genre_ids': genre_ids,
      'id': id,
      'original_title': original_title,
      'original_language': original_language,
      'title': title,
      'backdrop_path': backdrop_path,
      'popularity': popularity,
      'vote_count': vote_count,
      'video': video,
      'vote_average': vote_average,
    };
  }

  static Result fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Result(
      poster_path: map['poster_path'],
      adult: map['adult'],
      overview: map['overview'],
      release_date: map['release_date'],
      genre_ids: List<int>.from(map['genre_ids']),
      id: map['id'],
      original_title: map['original_title'],
      original_language: map['original_language'],
      title: map['title'],
      backdrop_path: map['backdrop_path'],
      popularity: map['popularity'],
      vote_count: map['vote_count'],
      video: map['video'],
      vote_average: map['vote_average'],
    );
  }

  String toJson() => json.encode(toMap());

  static Result fromJson(String source) => fromMap(json.decode(source));
  @override
  String toString() {
    return this.title;
  }

  @override
  List<Object> get props => [id];
}
