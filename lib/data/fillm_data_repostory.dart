import 'dart:convert';
import 'model/Response.dart';
import 'package:http/http.dart' as http;
import 'model/media.dart';

enum DataListType {
  Popular_This_Season,
  Highly_Anticipated_Next_Season,
  Highest_Rated_All_Time,
  All_Time_Popular
}

String getQuery(DataListType dataListType, {int page = 1, int perPage = 6}) {
  var nextSeason = "WINTER";
  var nextYear = 2020;
  var thisSeason = "FALL";
  var thisYear = 2019;

  var query;
  var type;

  switch (dataListType) {
    case DataListType.Popular_This_Season:
      query =
          "media(season: $thisSeason, seasonYear: $thisYear, status: RELEASING, sort: POPULARITY_DESC, type: ANIME, isAdult: false) {$mediaQuery}";
      break;
    case DataListType.Highly_Anticipated_Next_Season:
      query =
          "media(season: $nextSeason, seasonYear: $nextYear, sort: POPULARITY_DESC, type: ANIME, isAdult: false) {$mediaQuery}";
      break;
    case DataListType.Highest_Rated_All_Time:
      query =
          "media(sort: SCORE_DESC, type: ANIME, isAdult: false) {$mediaQuery}";
      break;
    case DataListType.All_Time_Popular:
      query =
          "media(sort: POPULARITY_DESC, type: ANIME, isAdult: false) { $mediaQuery}";
      break;
  }
  return "${dataListType.toString().split(".")[1]}: Page(page: $page, perPage: $perPage) {$query}";
}

class FilmDataRepository {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Map<String, List<MediaThumbModel>>> getAnimeList() async {
    var query = """{
      ${getQuery(DataListType.Popular_This_Season)}
      ${getQuery(DataListType.Highly_Anticipated_Next_Season)}
      ${getQuery(DataListType.Highest_Rated_All_Time)}
      ${getQuery(DataListType.All_Time_Popular)}
  }""";

    Map<String, String> requestMap = {"query": query};
    String requestBody = json.encode(requestMap);

    var response = await http.post("https://graphql.anilist.co",
        body: requestBody, headers: headers);

    if (response.statusCode == 200) {
      var popularThisSeason = _parseResponse("Popular_This_Season", response);
      var nextSeasonAnticipated =
          _parseResponse("Highly_Anticipated_Next_Season", response);
      var allTimeRated = _parseResponse("Highest_Rated_All_Time", response);
      var alltimePopular = _parseResponse("All_Time_Popular", response);
      return {
        "Popular this season": popularThisSeason,
        "Highly Anticipated Next Season": nextSeasonAnticipated,
        "Highest Rated All Time": allTimeRated,
        "All Time Popular": alltimePopular,
      };
    } else {
      throw Exception('Failed to load data');
    }
  }

  _parseResponse(String title, http.Response response) {
    var result = ApiResponse.fromJson(
        json.decode(response.body),
        "data",
        (data) => ApiResponse.fromJson(
            data,
            title,
            (page) => (page["media"] as List)
                .map((it) => MediaThumbModel.fromJson(it))
                .toList()));
    return result.data.data;
  }

  Future<List<MediaThumbModel>> getAnimeListWithPagination(
      DataListType type, int offset, int pagingSize) async {
    int page = (offset ~/ pagingSize) + 1;
    var query = "{${getQuery(type, page: page, perPage: pagingSize)}}";

    Map<String, String> requestMap = {"query": query};
    String requestBody = json.encode(requestMap);

    var response = await http.post("https://graphql.anilist.co",
        body: requestBody, headers: headers);

    if (response.statusCode == 200) {
      var popularThisSeason =
          _parseResponse(type.toString().split(".")[1], response);
      return popularThisSeason;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MediaModel> getMediaDetails(int id) async {
    Map<String, String> requestMap = {"query": mediaWithIdQuery(id)};
    String requestBody = json.encode(requestMap);

    var response = await http.post("https://graphql.anilist.co",
        headers: headers, body: requestBody);

    if (response.statusCode == 200) {
      var result = ApiResponse.fromJson(
          json.decode(response.body),
          "data",
          (data) => ApiResponse.fromJson(
              data, "Media", (media) => MediaModel.fromJson(media)));
      return result.data.data;
    } else {
      print("something went wrong - ${response.body}");
      throw Exception('Failed to load data');
    }
  }
}

mediaWithIdQuery(int id) => """{Media(id: $id){$mediaQuery}}""";

final mediaQuery = """
  id
  title {
    english,
    userPreferred
  }
  coverImage {large,extraLarge, medium}
  startDate {
    year
    month
    day
  }
  endDate {
    year
    month
    day
  }
  season
  description
  type
  format
  status
  genres
  isAdult
  averageScore
  favourites
  popularity
  mediaListEntry {
    id
    status
  }
  nextAiringEpisode {
    airingAt
    timeUntilAiring
    episode
  }
  studios(isMain: true) {
    edges {
      isMain
      node {
        id
        name
      }
    }
  }
""";

var mediaFragment = """
fragment media on Media {
  $mediaQuery
}""";
