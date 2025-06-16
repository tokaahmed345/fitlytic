import 'dart:convert';
import 'package:flutter_application_depi/model/exercise_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'exercise_state.dart';
import 'package:http/http.dart' as http;

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit() : super(ExerciseInitial());
  
  final String baseUrl = 'https://exercisedb-api.vercel.app/api/v1/exercises?offset=0&limit=100';
  
  // List to store all fetched exercises
  List<ExcersiceModel> _allExercises = [];
  
  // Fetch all exercises from API
  void fetchExercises() async {
    emit(ExerciseLoading());
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final Map data = jsonDecode(response.body);
        _allExercises = (data['data']['exercises'] as List)
            .map((e) => ExcersiceModel.fromJson(e))
            .toList();
        emit(ExerciseLoaded(_allExercises));
      } else {
        emit(ExerciseError('Failed to load exercises: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ExerciseError('Error fetching exercises: $e'));
    }
  }
  
  // Filter exercises by target muscle
  void filterByTargetMuscle(String? targetMuscle, {String? secondTargetedMuscle}) {
  // First ensure we have exercises loaded
  if (_allExercises.isEmpty) {
    if (targetMuscle == null) {
      fetchExercises();
    } else {
      fetchExercisesAndFilter(targetMuscle, );
    }
    return;
  }

  // Debug prints to understand the filtering parameters

  // Filter exercises
  final filteredExercises = _allExercises.where((exercise) {
    // Skip exercises without body parts
    if (exercise.bodyParts == null || exercise.bodyParts!.isEmpty) {
      return false;
    }

    // No filtering needed if no target muscle specified
    if (targetMuscle == null) {
      return true;
    }

    // Normalize the target strings
    final primaryTarget = targetMuscle.toLowerCase();
    final secondaryTarget = secondTargetedMuscle?.toLowerCase();

    // Check primary target
    final containsPrimary = exercise.bodyParts!.any(
      (part) => part.toLowerCase().contains(primaryTarget)
    );

    // If no secondary target, just check primary
    if (secondaryTarget == null) {
      return containsPrimary;
    }

    // Check secondary target
    final containsSecondary = exercise.bodyParts!.any(
      (part) => part.toLowerCase().contains(secondaryTarget)
    );

    // Return true if either target matches
    return containsPrimary || containsSecondary;
  }).toList();

  emit(ExerciseLoaded(filteredExercises));
}
  
  // Fetch exercises and then apply filter
  void fetchExercisesAndFilter(String targetMuscle) async {
    emit(ExerciseLoading());
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final Map data = jsonDecode(response.body);
        _allExercises = (data['data']['exercises'] as List)
            .map((e) => ExcersiceModel.fromJson(e))
            .toList();
        final filteredExercises = _allExercises.where((exercise) {
          return exercise.bodyParts![0].contains(targetMuscle.toLowerCase());
        }).toList();
        
        emit(ExerciseLoaded(filteredExercises));
      } else {
        emit(ExerciseError('Failed to load exercises: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ExerciseError('Error fetching exercises: $e'));
    }
  }
  
  // Reset filters to show all exercises
  void resetFilters() {
    if (_allExercises.isNotEmpty) {
      emit(ExerciseLoaded(_allExercises));
    } else {
      fetchExercises();
    }
  }
  // In your ExerciseCubit
void resetState() {
  emit(ExerciseInitial()); // Or whatever your initial state is
}
}