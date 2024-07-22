import 'package:http/http.dart' as https;
import 'package:movie/core/constants.dart';

class BrowseServices {
  Future<https.Response> getBrowseCategory() async {
    Map<String, dynamic>? queryParameters = {"api_key": Constants.apiKey};
    Uri uri =
    Uri.https(Constants.baseURL, "/3/genre/movie/list", queryParameters);

    return await https.get(uri);
  }

  Future<https.Response> getBrowseMovies() async {
    Map<String, dynamic>? queryParameters = {
      "api_key": Constants.apiKey,
      // "with_genres": genreId
    };

    Uri uri =
    Uri.https(Constants.basUlrHome, '/3/discover/movie', queryParameters);
    return await https.get(uri);
  }}
