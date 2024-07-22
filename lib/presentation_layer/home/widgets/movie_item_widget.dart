import 'package:flutter/material.dart';

import 'package:movie/data_layer/services/watch_list_services/watch_list_services.dart';

import '../../../data_layer/models/watch_list_model/watch_list_model.dart';
import '../details_view/details_view.dart';

class MovieItemWidget extends StatefulWidget {
  MovieItemWidget(
      {super.key,
      required this.bookmarkVisible,
      required this.id,
      required this.title,
      required this.heightImage,
      required this.imageNetwork,
      required this.ableNavigate,
      required this.date,
      required this.originalTitle,
      required this.widthImage});

  final String imageNetwork;
  final double heightImage;
  final double widthImage;
  final String title;
  final String id;
  final String date;
  final String originalTitle;
  final bool bookmarkVisible;
  final bool ableNavigate;

  @override
  State<MovieItemWidget> createState() => _MovieItemWidgetState();
}

class _MovieItemWidgetState extends State<MovieItemWidget> {
  bool saved = false;

  @override
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return widget.bookmarkVisible == true
        ? Stack(
            alignment: Alignment.topLeft,
            children: [
              CustomClipRRect(
                  ableNavigate: widget.ableNavigate,
                  imageNetwork: widget.imageNetwork,
                  widthImage: widget.widthImage,
                  heightImage: widget.heightImage,
                  id: widget.id,
                  title: widget.title),
              GestureDetector(
                onTap: () async {
                  WatchListModel model = WatchListModel(
                      image: widget.imageNetwork,
                      title: widget.title,
                      date: widget.date,
                      id: widget.id,
                      originalTitle: widget.originalTitle);
                  bool invilade = true;

                  await WatchListServices.addDataToFireStore(model);

                  setState(() {
                    saved = !saved;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: const Alignment(0, -0.5),
                      children: [
                        Image.asset("assets/icons/Icon awesome-bookmark.png",
                            color: saved == true
                                ? theme.colorScheme.primary
                                : const Color(0xff514F4F)),
                        saved == true
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            :const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        : CustomClipRRect(
            ableNavigate: widget.ableNavigate,
            imageNetwork: widget.imageNetwork,
            widthImage: widget.widthImage,
            heightImage: widget.heightImage,
            id: widget.id,
            title: widget.title);
  }
}

class CustomClipRRect extends StatelessWidget {
  const CustomClipRRect(
      {super.key,
      required this.imageNetwork,
      required this.heightImage,
      required this.widthImage,
      required this.id,
      required this.title,
      required this.ableNavigate});

  final String imageNetwork;
  final double heightImage;
  final double widthImage;
  final String title;
  final String id;
  final bool ableNavigate;

  @override
  Widget build(BuildContext context) {
    return ableNavigate == true
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsView(
                      title: title,
                      id: id,
                    ),
                  ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imageNetwork,
                height: heightImage,
                width: widthImage,
                fit: BoxFit.cover,
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              imageNetwork,
              height: heightImage,
              width: widthImage,
              fit: BoxFit.cover,
            ),
          );
  }
}
