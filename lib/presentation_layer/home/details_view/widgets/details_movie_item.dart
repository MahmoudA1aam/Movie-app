
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data_layer/models/details_movie_model/details_movie_model.dart';
import '../../widgets/movie_item_widget.dart';
import 'genre_item.dart';

class DetailsMovieItem extends StatelessWidget {
  const DetailsMovieItem(
      {super.key,
      required this.genres,
      required this.imageNetwork,
      required this.description,
        required this.title,
        required this.id,
        required this.originalTitle,
        required this.date,
      required this.rate});
final  String originalTitle;
final  String date;
final  String title;
final  String id;

  final String imageNetwork;
  final String description;
  final double rate;
  final List<Genres> genres;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return SizedBox(
      height: mediaQuery.height * 0.230,
      child: Row(
        children: [
          MovieItemWidget(

            date: date,
            originalTitle:originalTitle,
            id: id,
            title: title,
            bookmarkVisible: true,
            heightImage: mediaQuery.height * 0.230,
            imageNetwork: imageNetwork,
            ableNavigate: false,
            widthImage: mediaQuery.width * 0.34,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: mediaQuery.width * 0.032),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children:
                        genres.map((e) => GenreItem(name: e.name!)).toList(),
                  ),
                  Text(
                    description,
                    style: theme.textTheme.bodyLarge,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFBB3B),
                        size: 22,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        rate.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
