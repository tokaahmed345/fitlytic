import 'exercise_model.dart';

class ExerciseResponse {
  final List<ExcersiceModel> exercises;
  final int currentPage;
  final int totalPages;
  final String? nextPage;

  ExerciseResponse({
    required this.exercises,
    required this.currentPage,
    required this.totalPages,
    required this.nextPage,
  });

  factory ExerciseResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ExerciseResponse(
      exercises: List<Map<String, dynamic>>.from(data['exercises'])
          .map((e) => ExcersiceModel.fromJson(e))
          .toList(),
      currentPage: data['currentPage'],
      totalPages: data['totalPages'],
      nextPage: data['nextPage'],
    );
  }
}
