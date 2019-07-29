import 'model/film_model.dart';

class FilmDataRepository {
  Future<List<FilmModel>> getFilmThumbList() async {
    await Future.delayed(Duration(seconds: 2));
    return FilmDemo.getFilmList();
  }
}

class FilmDemo {
  static getFilmList() {
    List<FilmModel> result = new List();
    result.add(FilmModel(
        'https://planetside.co.uk/wp-content/uploads/2016/10/tron_legacy_final_poster_hi-res_01.jpg',
        'Tron',
        "Auth Auth",
        3.4,
        12344));
    result.add(FilmModel(
        'https://m.media-amazon.com/images/M/MV5BMjA5NzA5NjMwNl5BMl5BanBnXkFtZTgwNjg2OTk2NzM@._V1_.jpg',
        'GOT',
        "Auth Auth",
        3.4,
        12344));
    result.add(FilmModel(
        'https://musicart.xboxlive.com/7/2bb22f00-0000-0000-0000-000000000002/504/image.jpg?w=1920&h=1080',
        'Throne of Atlantis',
        "Auth Auth",
        3.4,
        12344));
    return result;
  }
}
