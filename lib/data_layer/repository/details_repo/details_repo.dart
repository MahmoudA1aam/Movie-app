import 'dart:convert';

import '../../models/details_movie_model/details_movie_model.dart';
import '../../models/details_movie_model/more_like_model.dart';
import '../../services/details_services/details_service.dart';

class DetailsRepository {
  DetailsService detailsService;

  DetailsRepository({required this.detailsService});

  Future<DetailsMovieModel> getDetailsMovie({required String movieId}) async {
    final response = await detailsService.fetchDetailsMovie(movieId: movieId);

    DetailsMovieModel detailsMovieModel =
        DetailsMovieModel.fromJson(jsonDecode(response.body));
    return detailsMovieModel;
  }

  Future<MoreLikeModel> fetchMoreLike({required String id}) async {
    final response = await detailsService.fetchMoreLike(id: id);

    if (response.statusCode == 200) {
      MoreLikeModel moreLikeModel =
          MoreLikeModel.fromJson(jsonDecode(response.body));
      return moreLikeModel;
    }
    throw Exception("Error no moRe Like");
  }
}
