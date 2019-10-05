import 'package:bloc_bases/data/fillm_data_repostory.dart';
import 'package:bloc_bases/data/model/media.dart';

abstract class DataListEvent  {
}

class FetchListDataEvent extends DataListEvent {
  final DataListType type;
  final List<MediaThumbModel> curDataList;
  final int paginSize;
  FetchListDataEvent(this.type, this.curDataList, this.paginSize);
}
