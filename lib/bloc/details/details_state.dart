import 'package:bloc_bases/data/model/media.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DetailsState extends Equatable {
  DetailsState([List props = const <dynamic>[]]) : super(props);
}

class InitialDetailsState extends DetailsState {}

class EmptyDetailsState extends DetailsState {}

class SuccessDetailsState extends DetailsState {
  final MediaModel result;
  SuccessDetailsState(this.result);
}

class ErrorDetailsState extends DetailsState {}
