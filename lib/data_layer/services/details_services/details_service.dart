import 'package:http/http.dart' as https;
import 'package:movie/core/constants.dart';

import '../../models/details_movie_model/more_like_model.dart';

class DetailsService {
  Future<https.Response> fetchDetailsMovie({required String movieId}) async {
    Map<String, dynamic>? queryParameters = {
      "api_key": Constants.apiKey,
    };
    Uri uri =
        Uri.https(Constants.baseURL, "/3/movie/${movieId}", queryParameters);
    return await https.get(uri);
  }

   Future<https.Response> fetchMoreLike({required String id}) async {
    Map<String, dynamic>? queryParameters = {"api_key": Constants.apiKey};
    Uri uri = Uri.https(
        Constants.basUlrHome, "/3/movie/${id}/similar", queryParameters);
    return await https.get(uri);
  }
}
