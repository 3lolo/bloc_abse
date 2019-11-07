import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_bases/data/db_storage.dart';
import 'package:bloc_bases/data/model/favorite.dart';
import 'package:bloc_bases/data/model/media.dart';
import '../../data/fillm_data_repostory.dart';
import '../bloc.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final FilmDataRepository _filmDataRepository;
  final DbStorage _dbStorage;
  DetailsBloc(this._filmDataRepository, this._dbStorage);

  @override
  DetailsState get initialState => InitialDetailsState();

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is FetchMediaDatailsEvent) {
      MediaModel result = await _actionGetData(event.id);
      MediaFavorite favorite = await _dbStorage.getFavorite(event.id);
      result.isSaved = (favorite?.isFlaged) ?? false;
      result.isLikedByMe = (favorite?.isFavorite) ?? false;
      yield SuccessDetailsState(result);
    } else if (event is UpdateDatailsEvent) {
      _dbStorage.insertFavorite(event.id, event.isFavorite, event.isFlaged);
      event.media.isLikedByMe = event.isFavorite;
      event.media.isSaved = event.isFlaged;
      yield SuccessDetailsState(event.media);
    }
  }

  fetchData(int id) => dispatch(FetchMediaDatailsEvent(id));
  
  Future<MediaModel> _actionGetData(int id) =>
      _filmDataRepository.getMediaDetails(id);

  updateFavorites(MediaModel media, bool isLiked, bool isFlaged) =>
      dispatch(UpdateDatailsEvent(media, media.id, isLiked, isFlaged));
}
