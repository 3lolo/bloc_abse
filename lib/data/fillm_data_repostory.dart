import 'dart:convert';
import 'model/Response.dart';
import 'package:http/http.dart' as http;
import 'model/media.dart';

class FilmDataRepository {
  // Future<List<MediaThumbModel>> getFilmThumbList() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   return FilmDemo.getFilmList();
  // }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<MediaThumbModel>> getAnimeList() async {
    var query = """{
  Page(perPage: 10) {
    mediaList(type: ANIME) {
      mediaId
      media {
        id
        title {
          english
          userPreferred
        }
        coverImage {
          medium
          extraLarge
        }
        favourites
        averageScore
      }
    }
  }
}
""";

    Map<String, String> requestMap = {"query": query};
    String requestBody = json.encode(requestMap);

    // var client = MyClient(http.Client());
    // client.head("https://graphql.anilist.co", headers: headers);
    // print("requestBody:$requestBody");
    // var response = await client.post("https://graphql.anilist.co",
    //     body: requestBody, headers: headers);

    var response = await http.post("https://graphql.anilist.co",
        body: requestBody, headers: headers);
    // print("requestBody:$requestBody");

    if (response.statusCode == 200) {
      var result = ApiResponse.fromJson(
          json.decode(response.body),
          "data",
          (data) => ApiResponse.fromJson(
              data,
              "Page",
              (page) => (page["mediaList"] as List)
                  .map((it) => MediaThumbModel.fromJson(it))
                  .toList()));
      //  MediaThumbModel.fromJson(json.decode(response.body));
      return result.data.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MediaModel> getMediaDetails(int id) async {
    var query = """{
  Media(id: $id) {
    id
    title {
      english
      userPreferred
    }
    coverImage {
      medium
      extraLarge
    }
    description
    type
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
    popularity
    isAdult
    studios {
      nodes {
        name
      }
      edges {
        id
      }
    }
    genres
    favourites
    averageScore
  }
}
""";

    Map<String, String> requestMap = {"query": query};
    String requestBody = json.encode(requestMap);

    // var client = MyClient(http.Client());
    // client.head("https://graphql.anilist.co", headers: headers);
    // print("requestBody:$requestBody");

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

// class MyClient extends BaseClient {
//   MyClient(this.delegate);
//   final Client delegate;
//   Future<StreamedResponse> send(BaseRequest request) {
//     _logRequest(request);
//     return delegate.send(request);
//   }

//   void close() => delegate.close();
//   void _logRequest(BaseRequest request) => print("""$request
//   ${request.headers}, 
//   Content-Lenght:${request.contentLength}
//   ${request.toString()}""");
// }