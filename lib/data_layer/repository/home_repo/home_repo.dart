import 'dart:convert';

import '../../models/home_model/new_release_model.dart';

import '../../models/home_model/popular_movie_model.dart';
import '../../models/home_model/recommended_model.dart';
import '../../services/home_services/home_services.dart';

class HomeBaseRepository {
  final HomeServices homeServices;

  HomeBaseRepository({required this.homeServices});

  Future<PopularMovieModel> getPopularMovie() async {
    final response = await homeServices.fetchPopularMovie();

    if (response.statusCode == 200) {
      PopularMovieModel popularModel =
          PopularMovieModel.fromJson(jsonDecode(response.body));
      return popularModel;
    }

    throw Exception("failed to load movie");
    // TODO
  }

  Future<NewReleasesMovieModel> fetchNewReleases() async {
    final response = await homeServices.fetchNewReleases();
    if (response.statusCode == 200) {
      NewReleasesMovieModel newReleasesMovie =
          NewReleasesMovieModel.fromJson(jsonDecode(response.body));
      return newReleasesMovie;
    }
    throw Exception("failed to load movie");
  }

  Future<RecommendedModel> fetchRecommendedList() async {
    final response = await homeServices.fetchRecommendedList();
    if (response.statusCode == 200) {
      RecommendedModel recommendedModel =
          RecommendedModel.fromJson(jsonDecode(response.body));
      return recommendedModel;
    }
    throw Exception("failed to load movie");
  }
}
