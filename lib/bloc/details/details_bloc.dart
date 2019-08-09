import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../data/fillm_data_repostory.dart';
import '../bloc.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final FilmDataRepository filmDataRepository;
  DetailsBloc(this.filmDataRepository);

  @override
  DetailsState get initialState => InitialDetailsState();

  @override
  Stream<DetailsState> mapEventToState(
    DetailsEvent event,
  ) async* {
    if (event is FetchMediaDatailsEvent) {
      final result = await _actionGetData(event.id);
      yield SuccessDetailsState(result);
    }
  }

  fetchData(int id) => dispatch(FetchMediaDatailsEvent(id));
  _actionGetData(int id) => filmDataRepository.getAnimeDetails(id);
}
