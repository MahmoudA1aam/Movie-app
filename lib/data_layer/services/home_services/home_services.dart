import 'package:http/http.dart' as https;

import '../../../core/constants.dart';

class HomeServices {
  Future<https.Response> fetchPopularMovie() async {
    Map<String, dynamic>? queryParameters = {
      "api_key": Constants.apiKey,
    };
    Uri uri =
        Uri.https(Constants.basUlrHome, "/3/movie/popular", queryParameters);
    return await https.get(uri);
  }

  Future<https.Response> fetchNewReleases() async {
    Map<String, dynamic>? queryParameters = {
      "api_key": Constants.apiKey,
    };

    Uri uri =
        Uri.https(Constants.baseURL, "/3/discover/movie", queryParameters);
    return await https.get(uri);
  }

  Future<https.Response> fetchRecommendedList() async {
    Map<String, dynamic> queryParameters = {
      "api_key": Constants.apiKey,
    };
    Uri uri =
        Uri.https(Constants.baseURL, "/3/movie/top_rated", queryParameters);
    return await https.get(uri);
  }
}
