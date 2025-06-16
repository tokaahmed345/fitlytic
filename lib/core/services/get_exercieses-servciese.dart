import 'package:dio/dio.dart';
import 'package:flutter_application_depi/model/exercise_model.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Dio dio = createSetUp();
  static Dio createSetUp() {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: false,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
    return dio;
  }
  Future<List<ExcersiceModel>> getExerciseByName(String termName) async {
  try {
    Response response = await dio.get(
      "https://exercisedb-api.vercel.app/api/v1/exercises",
      queryParameters: {
        "search": termName,
        "limit": 20,
      },
    );

    if (response.statusCode == 200) {
      var exercises = response.data['data']['exercises'];

      if (exercises is List) {
        return exercises.map((item) => ExcersiceModel.fromJson(item)).toList();
      } else {
        throw Exception("Expected a list of exercises, but got something else.");
      }
    } else {
      throw Exception("Error in response: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Search failed: $e");
  }
}


}
