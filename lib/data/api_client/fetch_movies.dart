import 'package:http/http.dart' as http;
import 'package:myapp/data/api_client/models/movie.dart';
import 'dart:convert';

import 'package:myapp/utils/utils.dart';

class FetchMovies {
  static void fetchFirstMovies(
      {required Function(dynamic data, bool error) onResponse}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      var req = await http.post(
        Uri.parse("$API_HOST/netnaija"),
        body: json.encode({"query": "max-results=24"}),
        headers: headers,
      );
      var res = json.decode(req.body);
      if (res['success'] != null) {
        List<Movie> movies =
            (res['data'] as List).map((e) => Movie.fromJson(e)).toList();
        onResponse(movies, false);
        return;
      }
      if (res['error'] != null) {
        onResponse(res, true);
        return;
      }
      onResponse(null, true);
    } catch (e) {
      onResponse(e.toString(), true);
      return;
    }
  }

  static void fetchMoreMovies({
    required String page,
    required Function(dynamic data, bool error) onResponse,
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      var req = await http.post(
        Uri.parse("$API_HOST/netnaija"),
        body: json.encode({"page": page}),
        headers: headers,
      );
      var res = json.decode(req.body);
      if (res['success'] != null) {
        List<Movie> movies =
            (res['data'] as List).map((e) => Movie.fromJson(e)).toList();
        onResponse(movies, false);
        return;
      }
      if (res['error'] != null) {
        onResponse(res, true);
        return;
      }
      onResponse(null, true);
    } catch (e) {
      onResponse(e.toString(), true);
      return;
    }
  }

  static void fetchSingleMovie({
    required String url,
    required Function(dynamic data, bool error) onResponse,
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      var req = await http.post(
        Uri.parse("$API_HOST/netnaija/details"),
        body: json.encode({"url": url}),
        headers: headers,
      );
      var res = json.decode(req.body);
      print(res['data']['downloadUrl']);
      if (res['success'] != null) {
        MovieDetails movie = MovieDetails.fromJson(res['data']);
        onResponse(movie, false);
        return;
      }
      if (res['error'] != null) {
        onResponse(res, true);
        return;
      }
      onResponse(null, true);
    } catch (e) {
      onResponse(e.toString(), true);
      return;
    }
  }
}
