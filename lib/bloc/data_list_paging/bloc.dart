import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_bases/bloc/data_list_paging/state.dart';
import 'package:bloc_bases/data/fillm_data_repostory.dart';
import 'package:bloc_bases/data/model/media.dart';

import 'event.dart';

class DataListPagingBloc extends Bloc<DataListEvent, DataListState> {
  final FilmDataRepository filmDataRepository;

  DataListPagingBloc(this.filmDataRepository);

  @override
  DataListState get initialState => InitialState();

  @override
  Stream<DataListState> mapEventToState(DataListEvent event) async* {
    if (event is FetchListDataEvent) {
      final result = await filmDataRepository.getAnimeListWithPagination(
          event.type, event.curDataList.length, event.paginSize);
      yield new SuccessState(
          result.length >= event.paginSize, event.curDataList + result);
    }
  }

  fetchData(DataListType type, List curDataList, int paginSize) =>
      dispatch(FetchListDataEvent(
          type, curDataList ?? List<MediaThumbModel>(), paginSize));
}
