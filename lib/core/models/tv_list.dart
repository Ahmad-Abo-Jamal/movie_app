import 'dart:convert';

import 'package:equatable/equatable.dart';

class TvList extends Equatable {
  final int page;
  final List<TvResult> results;
  final int total_pages;
  final int total_results;
  TvList({
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

  static TvList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TvList(
      page: map['page'],
      results:
          List<TvResult>.from(map['results']?.map((x) => TvResult.fromMap(x))),
      total_pages: map['total_pages'],
      total_results: map['total_results'],
    );
  }

  String toJson() => json.encode(toMap());

  static TvList fromJson(String source) => fromMap(json.decode(source));

  @override
  // TODO: implement props
  List<Object> get props => [page, total_pages, total_results];
}

class TvResult extends Equatable {
  final String poster_path;
  final String overview;
  final String release_date;
  final List<int> genre_ids;
  final int id;
  final num vote_average;
  final String original_language;
  final String name;
  final String first_air_date;
  final String backdrop_path;
  final num popularity;
  final int vote_count;

  final String original_name;
  TvResult({
    this.poster_path,
    this.overview,
    this.release_date,
    this.genre_ids,
    this.id,
    this.vote_average,
    this.original_language,
    this.name,
    this.first_air_date,
    this.backdrop_path,
    this.popularity,
    this.vote_count,
    this.original_name,
  });

  @override
  List<Object> get props {
    return [
      poster_path,
      overview,
      release_date,
      genre_ids,
      id,
      vote_average,
      original_language,
      name,
      first_air_date,
      backdrop_path,
      popularity,
      vote_count,
      original_name,
    ];
  }

  TvResult copyWith({
    String poster_path,
    String overview,
    String release_date,
    List<int> genre_ids,
    int id,
    int vote_average,
    String original_language,
    String name,
    String first_air_date,
    String backdrop_path,
    num popularity,
    int vote_count,
    String original_name,
  }) {
    return TvResult(
      poster_path: poster_path ?? this.poster_path,
      overview: overview ?? this.overview,
      release_date: release_date ?? this.release_date,
      genre_ids: genre_ids ?? this.genre_ids,
      id: id ?? this.id,
      vote_average: vote_average ?? this.vote_average,
      original_language: original_language ?? this.original_language,
      name: name ?? this.name,
      first_air_date: first_air_date ?? this.first_air_date,
      backdrop_path: backdrop_path ?? this.backdrop_path,
      popularity: popularity ?? this.popularity,
      vote_count: vote_count ?? this.vote_count,
      original_name: original_name ?? this.original_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'poster_path': poster_path,
      'overview': overview,
      'release_date': release_date,
      'genre_ids': genre_ids,
      'id': id,
      'vote_average': vote_average,
      'original_language': original_language,
      'name': name,
      'first_air_date': first_air_date,
      'backdrop_path': backdrop_path,
      'popularity': popularity,
      'vote_count': vote_count,
      'original_name': original_name,
    };
  }

  factory TvResult.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TvResult(
      poster_path: map['poster_path'],
      overview: map['overview'],
      release_date: map['release_date'],
      genre_ids: List<int>.from(map['genre_ids']),
      id: map['id'],
      vote_average: map['vote_average'],
      original_language: map['original_language'],
      name: map['name'],
      first_air_date: map['first_air_date'],
      backdrop_path: map['backdrop_path'],
      popularity: map['popularity'],
      vote_count: map['vote_count'],
      original_name: map['original_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TvResult.fromJson(String source) =>
      TvResult.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
