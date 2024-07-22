import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data_layer/models/home_model/new_release_model.dart';
import '../../data_layer/models/home_model/popular_movie_model.dart';
import '../../data_layer/models/home_model/recommended_model.dart';
import '../../data_layer/repository/home_repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeBaseRepository})
      : super(
          HomeInitial(),
        );
  final HomeBaseRepository homeBaseRepository;
  List<ResultsPopular>? listPopularMovie = [];
  List<ResultsNewReleases> listNewRelease = [];
  List<ResultsNewReleases> searchedMovieList = [];
  List<ResultsRecommended> listRecommendedMovie = [];

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> getPopularMovie() async {
    emit(PopularMovieLoading());
    PopularMovieModel response = await homeBaseRepository.getPopularMovie();

    try {
      listPopularMovie = response.results;

      emit(PopularMovieSuccess());
    } on Exception catch (e) {
      emit(PopularMovieError());
      print(e);
      // TODO
    }
  }

  Future<void> getNewReleaseMovie() async {
    emit(NewReleaseLoading());
    final response = await homeBaseRepository.fetchNewReleases();

    try {
      listNewRelease = response.results ?? [];

      emit(NewReleaseSuccess());
    } on Exception catch (e) {
      emit(NewReleaseError());
      print(e);
      // TODO
    }
  }

  Future<void> getNewSearch(String value) async {
    emit(NewReleaseLoading());
    final response = await homeBaseRepository.fetchNewReleases();

    try {
      listNewRelease = response.results ?? [];

      searchedMovieList = listNewRelease!
          .where((e) => e.title!.toLowerCase().startsWith(value))
          .toList();
      emit(NewReleaseSuccess());
    } on Exception catch (e) {
      emit(NewReleaseError());
      print(e);
      // TODO
    }
  }

  Future<void> getRecommendedModel() async {
    emit(RecommendMovieLoading());
    final response = await homeBaseRepository.fetchRecommendedList();

    try {
      listRecommendedMovie = response.results ?? [];
      emit(RecommendMovieSuccess());
    } on Exception catch (e) {
      emit(RecommendMovieError());
      print(e);

      // TODO
    }
  }
}
