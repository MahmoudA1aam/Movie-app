import 'package:http/http.dart' as https;

import '../../../core/constants.dart';

class SearchServices {
  Future<https.Response> getSearch({required String query}) async {
    Map<String, dynamic>? queryParameters = {
      "api_key": Constants.apiKey,
      'query': query,
    };
    Uri uri = Uri.https(Constants.baseURL, '/3/search/movie', queryParameters);
    return await https.get(uri);
  }

}
