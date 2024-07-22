import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';
import 'package:movie/data_layer/services/watch_list_services/watch_list_services.dart';

import '../../data_layer/models/watch_list_model/watch_list_model.dart';

part 'watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  WatchListCubit({required this.watchListServices}) : super(WatchListInitial());
  WatchListServices watchListServices;
  List<WatchListModel> watchList = [];

  static WatchListCubit get(context) => BlocProvider.of(context);

  Future<void> getWatchList() async {
    emit(WatchListLoading());
    try {
      watchList = await watchListServices.getDataFromFireStore();
      emit(WatchListSuccess());
    } on Exception catch (e) {
      emit(WatchListError());
      // TODO
    }
  }

  Stream<QuerySnapshot<WatchListModel>> getDataRealTimeFromFireStore() {
    var snapshot = watchListServices.getDataRealTimeFromFireStore();
    return snapshot;
  }
}
