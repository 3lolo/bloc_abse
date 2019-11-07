import 'package:bloc_bases/data/model/media.dart';
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

class UpdateDatailsEvent extends DetailsEvent {
  final MediaModel media;
  final int id;
  final bool isFavorite;
  final bool isFlaged;

  UpdateDatailsEvent(this.media, this.id, this.isFavorite, this.isFlaged);
}
