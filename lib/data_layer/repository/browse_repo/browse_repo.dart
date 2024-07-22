import 'dart:convert';

import 'package:movie/data_layer/models/browse_model/browse_category_model.dart';

import 'package:movie/data_layer/services/browse_services/browse_services.dart';

import '../../models/browse_model/browse_movie_model.dart';

class BrowseRepository {
  BrowseServices browseServices;

  BrowseRepository({required this.browseServices});

  Future<BrowseCategoryModel> getBrowseCategory() async {
    final response = await browseServices.getBrowseCategory();

    BrowseCategoryModel browseCategoryModel =
        BrowseCategoryModel.fromJson(jsonDecode(response.body));
    return browseCategoryModel;
  }

  Future<BrowseMoviesModel> getBrowseMovies() async {
    final response = await browseServices.getBrowseMovies();
    BrowseMoviesModel browseMoviesModel =
        BrowseMoviesModel.fromJson(jsonDecode(response.body));
    return browseMoviesModel;
  }
}
