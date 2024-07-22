import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/business_logic_layer/details_bloc/details_cubit.dart';

import 'package:movie/core/constants.dart';
import 'package:movie/data_layer/repository/details_repo/details_repo.dart';
import 'package:movie/data_layer/services/details_services/details_service.dart';
import 'package:movie/presentation_layer/home/details_view/widgets/details_movie_item.dart';
import 'package:movie/presentation_layer/home/details_view/widgets/more_like_list.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({
    super.key,
    required this.title,
    required this.id,
  });

  static String routName = "Deails_view";
  final String title;
  final String id;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late DetailsCubit detailsCubit;

  @override
  void initState() {
    detailsCubit = DetailsCubit(
        detailsRepository: DetailsRepository(detailsService: DetailsService()));

    // viewModel = DetailsProvider();
    // Future.wait([viewModel.getDetailsMovie(widget.id)]).then((value) {
    //   if (value[0] == true) {
    //     return viewModel.gatMoreLikeList(viewModel.idList.toString());
    //   }
    // });

    Future.wait([detailsCubit.getDetailsMovie(movieId: widget.id)])
        .then((value) {
      if (value[0] == true) {
        return detailsCubit.getMoreLike(id: widget.id);
      }
    });


    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (context) {
        return detailsCubit;
      },
      child: Scaffold(
          backgroundColor: const Color(0xFF1D1E1D),
          appBar: AppBar(
            title: Text(
              widget.title,
            ),
          ),
          body: BlocBuilder<DetailsCubit, DetailsState>(
            builder: (context, state) {
              var cubit = DetailsCubit.get(context);
              if (state is DetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          "${Constants.basicImage}${cubit.posterPath}",
                          height: mediaQuery.height * 0.235,
                          width: mediaQuery.width,
                          fit: BoxFit.cover,
                        ),
                        const ImageIcon(
                          AssetImage("assets/icons/icon_display_popular.png"),
                          size: 55,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: mediaQuery.height * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cubit.title.toString(),
                              style: theme.textTheme.titleMedium),
                          SizedBox(
                            height: mediaQuery.height * 0.001,
                          ),
                          Text(cubit.releaseDate.toString(),
                              style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: const Color(0xFFB5B4B4),
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: mediaQuery.height * 0.01),
                      child: DetailsMovieItem(
                          id: "",
                          date: cubit.releaseDate.toString(),
                          title: cubit.title.toString(),
                          originalTitle: cubit.title.toString(),
                          genres: cubit.genresList,
                          rate: cubit.voteAverage!.toDouble(),
                          description: cubit.overview.toString(),
                          imageNetwork:
                              "${Constants.basicImage}${cubit.posterPath}"),
                    ),
                    SizedBox(
                      height: mediaQuery.height * 0.015,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15, top: mediaQuery.height * 0.01),
                      child: MoreLikeList(
                        moreLikeList: cubit.resultsMoreLikeList ?? [],
                      ),
                    )
                  ],
                );
              }
            },
          )),
    );
  }
}
