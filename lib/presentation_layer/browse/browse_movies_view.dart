import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie/data_layer/repository/browse_repo/browse_repo.dart';
import 'package:movie/data_layer/services/browse_services/browse_services.dart';
import 'package:movie/presentation_layer/browse/widgets/browse_movie_item.dart';



import '../../business_logic_layer/browse_bloc/browse_movie_bloc/browse_movie_cubit.dart';

class BrowseFilmView extends StatefulWidget {
  const BrowseFilmView({super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  State<BrowseFilmView> createState() => _BrowseFilmViewState();
}

class _BrowseFilmViewState extends State<BrowseFilmView> {
  late BrowseMovieCubit browseMovieCubit;

  @override
  void initState() {
    browseMovieCubit = BrowseMovieCubit(
        browseRepository: BrowseRepository(browseServices: BrowseServices()))
      ..getBrowseMovies();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return BlocProvider<BrowseMovieCubit>(
      create: (context) => browseMovieCubit,
      child: BlocBuilder<BrowseMovieCubit, BrowseMovieState>(
        builder: (context, state) {
          var cubit = BrowseMovieCubit.get(context);
          if (state is BrowseMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.only(
                left: mediaQuery.width * 0.04,
                right: mediaQuery.width * 0.04,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                        )),
                    Text(
                    widget.title,
                      style:  TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5 / 6,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: cubit.browseMovieList!.length,
                    itemBuilder: (context, index) {
                      return BrowseMovieItem(
                          list: cubit.browseMovieList![index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

