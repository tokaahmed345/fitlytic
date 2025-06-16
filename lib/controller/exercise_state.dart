import 'package:flutter_application_depi/model/exercise_model.dart';
import 'package:equatable/equatable.dart';
abstract class ExerciseState extends Equatable {

}

class ExerciseInitial extends ExerciseState {
  @override
  List<Object?> get props => [];
}

class ExerciseLoading extends ExerciseState {
  @override
  List<Object?> get props => [];
}

class ExerciseLoaded extends ExerciseState {
  final List<ExcersiceModel> exercises;

  ExerciseLoaded(this.exercises);

  @override
  List<Object?> get props => [exercises];
}

class ExerciseError extends ExerciseState {
  final String message;

  ExerciseError(this.message);

  @override
  List<Object?> get props => [message];
}
