import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_bases/bloc/bloc.dart';
import '../../data/fillm_data_repostory.dart';
import 'home_state.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FilmDataRepository filmDataRepository;

  HomeBloc(this.filmDataRepository);

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is FetchDataHomeEvent) {
      final result = await _actionGetData();
      yield SuccessHomeState(result);
      return;
    }
  }

  _actionGetData() async => await filmDataRepository.getFilmThumbList();

  fetchData() => dispatch(FetchDataHomeEvent());
}
