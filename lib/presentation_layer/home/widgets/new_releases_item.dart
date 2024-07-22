import 'package:flutter/material.dart';
import 'package:movie/core/constants.dart';




import '../../../data_layer/models/home_model/new_release_model.dart';
import 'movie_item_widget.dart';

class NewReleasesItem extends StatelessWidget {
  const NewReleasesItem({super.key, required this.results});

  final ResultsNewReleases results;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          top: mediaQuery.height * 0.01,
          bottom: mediaQuery.height * 0.013,
          right: mediaQuery.width * 0.028),
      child: MovieItemWidget(
        date: results.releaseDate.toString(),
          originalTitle: results.originalTitle.toString(),
        ableNavigate: true,
          bookmarkVisible: true,
          id: results.id.toString(),
          title: results.title.toString(),
          imageNetwork: "${Constants.basicImage}${results.posterPath}",
          heightImage: mediaQuery.height * 0.155,
          widthImage: mediaQuery.width * 0.259),
    );
  }
}
