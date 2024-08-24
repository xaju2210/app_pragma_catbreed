import 'package:app_pragma_prueba/config/api/cat/api.dart';
import 'package:app_pragma_prueba/config/api/cat/api_response.dart';
import 'package:app_pragma_prueba/entity/entity_cat.dart';

class RespositoryList {
  Future<ApiResponse<List<EntityCat>>> list() async {
    final dio = await Api.dio();

    final response = await dio.get(
      "breeds",
    );

    final result = ApiResponse.handler(
      response.data,
      (json) => List.generate(
        json.length,
        (index) => EntityCat.fromMap(json[index]),
      ),
    );

    return result;
  }

  Future<ApiResponse<String>> getImage(String pstrId) async {
    final dio = await Api.dio(authorization: ApiEnumTypeAuthentication.header);

    final response = await dio.get(
      "images/search",
      queryParameters: {
        "breed_ids": pstrId,
      },
    );

    final result = ApiResponse.handler(
      response.data,
      (json) => json.length == 0 ? "" : json[0]["url"] as String? ?? "",
    );

    return result;
  }
}
