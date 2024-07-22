import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data_layer/models/home_model/popular_movie_model.dart';
import '../../data_layer/repository/search_repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepository}) : super(SearchInitial());
  SearchRepository searchRepository;
  List<ResultsPopular> searchMovieList = [];
  String querySearch = '';

  List<ResultsPopular> searchedMovieList = [];

  static SearchCubit get(context) => BlocProvider.of(context);

  Future<void> getSearch({required String query}) async {
    emit(SearchLoading());
    final response = await searchRepository.getSearch(query: query);
    emit(SearchLoading());
    try {
      searchMovieList = response.results ?? [];
      querySearch = query;
      searchedMovieList = searchMovieList!
          .where((e) => e.title!.toLowerCase().startsWith(query))
          .toList();
      querySearch = query;
      emit(SearchSuccess());
    } on Exception catch (e) {
      emit(SearchError());
      print(e);
      // TODO
    }
  }
}
