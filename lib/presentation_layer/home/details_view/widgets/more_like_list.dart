import 'package:flutter/material.dart';




import '../../../../data_layer/models/details_movie_model/more_like_model.dart';
import 'more_like__item.dart';

class MoreLikeList extends StatelessWidget {
  const MoreLikeList({super.key, required this.moreLikeList});

  final List<ResultsMoreLikeList> moreLikeList;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ThemeData theme=Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
        top: mediaQuery.height * 0.01,
        left:  mediaQuery.width * 0.04,
      ),
      height: mediaQuery.height * 0.28,
      width: mediaQuery.width,
      color: const Color(0xFF282A28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "More Like This",
            style: theme.textTheme.titleSmall),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    MoreLikeItem(results: moreLikeList[index]),
                itemCount: moreLikeList.length),
          )
        ],
      ),
    );
  }
}
