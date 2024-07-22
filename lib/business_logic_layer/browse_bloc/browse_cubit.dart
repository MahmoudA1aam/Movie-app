import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie/data_layer/repository/browse_repo/browse_repo.dart';

import '../../data_layer/models/browse_model/browse_category_model.dart';
import '../../data_layer/models/browse_model/browse_movie_model.dart';

part 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit({required this.browseRepository}) : super(BrowseInitial());
  BrowseRepository browseRepository;
  List<Genres>? browseCategoryList = [];


  static BrowseCubit get(context) => BlocProvider.of(context);
  Future<void> getBrowseCategory() async {
    emit(BrowseLoading());
    final response = await browseRepository.getBrowseCategory();

    try {
      emit(BrowseLoading());
      browseCategoryList = response.genres;
      emit(BrowseSuccess());
    } on Exception catch (e) {
      emit(BrowseError());
      print(e);
      // TODO
    }
  }


}
