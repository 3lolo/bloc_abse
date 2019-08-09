import 'dart:convert';

import 'model/Response.dart';
import 'model/film_model.dart';
import 'package:http/http.dart' as http;

import 'model/media.dart';

class FilmDataRepository {
  Future<List<FilmModel>> getFilmThumbList() async {
    await Future.delayed(Duration(seconds: 2));
    return FilmDemo.getFilmList();
  }

  Future<List<FilmModel>> getAnimeList() async {
    final response =
        await http.get('https://api.jikan.moe/v3/top/anime/1/upcoming');

    if (response.statusCode == 200) {
      var result = ApiResponse<List<FilmModel>>.fromJson(
          json.decode(response.body),
          (data) => (data as List).map((i) => FilmModel.fromJson(i)).toList());
      return result.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MediaModel> getAnimeDetails(int id) async {
    final response = await http.get('https://api.jikan.moe/v3/anime/$id');

    if (response.statusCode == 200) {
      var result = MediaModel.fromJson(json.decode(response.body));
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class FilmDemo {
  static getFilmList() {
    String description =
        """In the medieval kingdom of Goredd, women are expected to be ladies, men are their protectors, and dragons get to be whomever they want. 
    Tess, stubbornly, is a troublemaker. You can’t make a scene at your sister’s wedding and break a relative’s nose with one punch (no matter how pompous he is)
     and not suffer the consequences. As her family plans to send her to a nunnery, Tess yanks on her boots and sets out on a journey across the Southlands, alone and pretending to be a boy.""";

    List<FilmModel> result = new List();
    result.add(FilmModel(0, 
        'https://planetside.co.uk/wp-content/uploads/2016/10/tron_legacy_final_poster_hi-res_01.jpg',
        'Tron',
        "Auth Auth",
        3.4,
        12344,
        description));
    result.add(FilmModel(0,
        'https://m.media-amazon.com/images/M/MV5BMjA5NzA5NjMwNl5BMl5BanBnXkFtZTgwNjg2OTk2NzM@._V1_.jpg',
        'GOT',
        "Auth Auth",
        3.4,
        12344,
        description));
    result.add(FilmModel(0,
        'https://musicart.xboxlive.com/7/2bb22f00-0000-0000-0000-000000000002/504/image.jpg?w=1920&h=1080',
        'Throne of Atlantis',
        "Auth Auth",
        3.4,
        12344,
        description));
    return result;
  }
}
