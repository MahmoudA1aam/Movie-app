import 'dart:convert';

import 'package:movie/data_layer/services/search_services/search_services.dart';

import '../../models/home_model/popular_movie_model.dart';




class SearchRepository {
  SearchRepository({required this.searchServices});

  SearchServices searchServices;

  Future<PopularMovieModel> getSearch({required String query}) async {
    final response = await searchServices.getSearch(query: query);

    if (response.statusCode == 200) {
      PopularMovieModel popularMovieModel =
      PopularMovieModel.fromJson(jsonDecode(response.body));
      return popularMovieModel;
    }

    throw Exception("Error not found movie");

    // TODO
  }
}
