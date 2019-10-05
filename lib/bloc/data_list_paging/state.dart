import 'package:bloc_bases/data/model/media.dart';

abstract class DataListState {}

class InitialState extends DataListState {}

class EmptyState extends DataListState {}

class SuccessState extends DataListState {
  final bool isLoadingEnabled;
  final List<MediaThumbModel> result;
  SuccessState(this.isLoadingEnabled, this.result);
}

class ErrorState extends DataListState {}
