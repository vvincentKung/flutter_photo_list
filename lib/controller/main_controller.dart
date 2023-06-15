import 'package:photo_list/model/photo_payload.dart';
import 'package:multiple_result/multiple_result.dart';
import '../remote/api_client.dart';
import '../remote/api_manager.dart';
import 'package:http/http.dart' as http;

class Controller {

  final int limit = 10;

  Future<Result<List<PhotoPayload>, Exception>> refreshData({String? searchKey}) async {

    try {
      List<PhotoPayload> data = (await ApiManager().fetchPhotos(apiClient, searchKey: searchKey));
      return Result.success(data);
    }on Exception catch(error){
      return Result.error(error);
    }
  }

  Future<Result<List<PhotoPayload>, Exception>> loadMoreData({int page = 1, String? searchKey}) async {
    try {
      List<PhotoPayload> data = (await ApiManager().fetchPhotos(apiClient, page: page, searchKey: searchKey));
      return Result.success(data);
    }on Exception catch(error){
      return Result.error(error);
    }
  }
}
