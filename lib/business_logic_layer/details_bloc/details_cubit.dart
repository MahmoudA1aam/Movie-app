import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';
import 'package:movie/data_layer/repository/details_repo/details_repo.dart';

import '../../data_layer/models/details_movie_model/details_movie_model.dart';
import '../../data_layer/models/details_movie_model/more_like_model.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit({required this.detailsRepository}) : super(DetailsInitial());
  DetailsRepository detailsRepository;
  String? title, overview, posterPath, releaseDate;
  double? voteAverage;

  List<Genres> genresList = [];
  List<ResultsMoreLikeList>? resultsMoreLikeList;

  static DetailsCubit get(context) => BlocProvider.of(context);

  Future<bool> getDetailsMovie({required String movieId}) async {
    emit(DetailsLoading());
    final response = await detailsRepository.getDetailsMovie(movieId: movieId);

    try {
      emit(DetailsSuccess());
      title = response.title;
      overview = response.overview;
      posterPath = response.posterPath;
      releaseDate = response.releaseDate;
      voteAverage = response.voteAverage;
      genresList = response.genres ?? [];
      return Future.value(true);

    } on Exception catch (e) {
      emit(DetailsError());
      return Future.value(false);
      print(e);
      // TODO
    }
  }

  Future<void> getMoreLike({required String id}) async {
    emit(MoreLikeLoading());
    final response = await detailsRepository.fetchMoreLike(id: id);
    try {
      resultsMoreLikeList = response.results;
      emit(MoreLikeSuccess());
    } on Exception catch (e) {
      emit(MoreLikeError());
      print(e);
      // TODO
    }
  }
}
