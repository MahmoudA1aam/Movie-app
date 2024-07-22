import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/business_logic_layer/home_bloc/home_cubit.dart';
import 'package:movie/presentation_layer/home/widgets/new_releases_lsit.dart';
import 'package:movie/presentation_layer/home/widgets/popular_movie_list.dart';
import 'package:movie/presentation_layer/home/widgets/recommended_list.dart';



class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is PopularMovieLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var cubit = HomeCubit.get(context);
          return Padding(
            padding: EdgeInsets.only(top: mediaQuery.height * 0.028),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PopularMovieList(popularList: cubit.listPopularMovie ?? []),
                SizedBox(
                  height: mediaQuery.height * 0.09,
                ),
                NewReleasesList(newReleasesList: cubit.listNewRelease),
                SizedBox(
                  height: mediaQuery.height * 0.02,
                ),
                RecommendedList(
                  recommendedList: cubit.listRecommendedMovie,
                )
              ],
            ),
          );
        }
      },
    );
    // return ChangeNotifierProvider(
    //   create: (context) => viewModel,
    //   child: Consumer<HomeProvider>(
    //     builder: (context, vm, child) {
    //       if (vm.apiSuccess == false) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //
    //       return Padding(
    //         padding: EdgeInsets.only(top: mediaQuery.height * 0.028),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             PopularMovieList(popularList: vm.popularList),
    //             SizedBox(
    //               height: mediaQuery.height * 0.09,
    //             ),
    //             NewReleasesList(newReleasesList: vm.newReleasesList),
    //             SizedBox(
    //               height: mediaQuery.height * 0.02,
    //             ),
    //             RecommendedList(
    //               recommendedList: vm.recommendedList,
    //             )
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
