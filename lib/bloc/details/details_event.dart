import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DetailsEvent extends Equatable {
  DetailsEvent([List props = const <dynamic>[]]) : super(props);
}

class FetchMediaDatailsEvent extends DetailsEvent {
  final int id;
  FetchMediaDatailsEvent(this.id);
}
