import 'dart:convert';

import 'package:photo_list/model/photo_payload.dart';
import 'package:http/http.dart' as http;

class ApiManager {

  static final ApiManager _instance = ApiManager._internal();
  final String _domain = "64266c9f556bad2a5b4f7749.mockapi.io";
  final client = http.Client();

  factory ApiManager() {
    return _instance;
  }


  ApiManager._internal();

  Future<List<PhotoPayload>> fetchPhotos(http.Client client, {int page = 1, int limit = 10, String sort = "takenAt", String? searchKey}) async {
    var parameters = Map<String, dynamic>();
    parameters['page'] = page.toString();
    parameters['limit'] = limit.toString();
    parameters['sortBy'] = sort;
    if(searchKey?.isNotEmpty ?? false){
      parameters['search'] = searchKey;
    }

    var url = Uri.https(_domain,"/photos", parameters);
    print(url);
    final response = await client.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return List<PhotoPayload>.from(json.decode(response.body).map((payload)=> PhotoPayload.fromJson(payload)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load photos');
    }
  }

}