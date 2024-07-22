import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data_layer/repository/browse_repo/browse_repo.dart';

import '../../../data_layer/models/browse_model/browse_movie_model.dart';

part 'browse_movie_state.dart';

class BrowseMovieCubit extends Cubit<BrowseMovieState> {
  BrowseMovieCubit({required this.browseRepository})
      : super(BrowseMovieInitial());
  BrowseRepository browseRepository;
  List<MoviesCateogryResults>? browseMovieList = [];

  static BrowseMovieCubit get(context) => BlocProvider.of(context);

  Future<void> getBrowseMovies() async {
    emit(BrowseMovieLoading());
    final response = await browseRepository.getBrowseMovies();
    try {
      emit(BrowseMovieLoading());
      browseMovieList = response.results;
      emit(BrowseMovieSuccess());
    } on Exception catch (e) {
      emit(BrowseMovieError());
      print(e);
      // TODO
    }
  }
}
