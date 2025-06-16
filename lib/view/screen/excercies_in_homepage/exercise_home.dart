import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/exercise_section.dart';

class DifficultySelectionScreen extends StatelessWidget {
  const DifficultySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDifficultyCard(
                context,
                'Easy',
                'Perfect for beginners',
                Colors.green,
                Icons.shield_outlined,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseListScreen(
                      difficulty: 'Easy',
                      exercises: easyExercises,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              buildDifficultyCard(
                context,
                'Medium',
                'For regular exercisers',
                Colors.amber,
                Icons.local_fire_department_outlined,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseListScreen(
                      difficulty: 'Medium',
                      exercises: mediumExercises,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              buildDifficultyCard(
                context,
                'Advanced',
                'Challenge yourself',
                Colors.redAccent,
                Icons.emoji_events_outlined,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseListScreen(
                      difficulty: 'Advanced',
                      exercises: advancedExercises,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

// Data models
class Exercise {
  final String name;
  final String description;
  final String imageUrl;
  final int sets;
  final String reps; // Can be "10-12" or "30 sec"
  final int restSeconds;
  final String equipment;
  final List<String> targetMuscles;

  Exercise({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.equipment,
    required this.targetMuscles,
  });
}

// Sample exercise data
final List<Exercise> easyExercises = [
  Exercise(
    name: 'Knee Push-ups',
    description:
        'A beginner-friendly version of push-ups performed with knees on the ground',
    imageUrl: 'assets/exercises/knee_push_up.jpg',
    sets: 3,
    reps: '8-10',
    restSeconds: 60,
    equipment: 'None',
    targetMuscles: ['Chest', 'Shoulders', 'Triceps'],
  ),
  Exercise(
    name: 'Wall Push-ups',
    description: 'Push-ups performed against a wall, perfect for beginners',
    imageUrl: 'assets/exercises/wall_push_up.jpg',
    sets: 3,
    reps: '10-12',
    restSeconds: 45,
    equipment: 'Wall',
    targetMuscles: ['Chest', 'Shoulders'],
  ),
  Exercise(
    name: 'Assisted Squats',
    description: 'Squats performed while holding onto a support for balance',
    imageUrl: 'assets/exercises/assisted_squats.jpg',
    sets: 3,
    reps: '10-12',
    restSeconds: 60,
    equipment: 'Chair or Support',
    targetMuscles: ['Legs'],
  ),
];

final List<Exercise> mediumExercises = [
  Exercise(
    name: 'Regular Push-ups',
    description: 'Standard push-ups from plank position',
    imageUrl: 'assets/exercises/regular_push_up.jpg',
    sets: 4,
    reps: '12-15',
    restSeconds: 45,
    equipment: 'None',
    targetMuscles: ['Chest', 'Shoulders', 'Triceps'],
  ),
  Exercise(
    name: 'Jump Squats',
    description: 'Dynamic squats with an explosive jump at the top',
    imageUrl: 'assets/exercises/jump_squats.jpg',
    sets: 3,
    reps: '15',
    restSeconds: 60,
    equipment: 'None',
    targetMuscles: ['Legs', 'Core'],
  ),
  Exercise(
    name: 'Mountain Climbers',
    description: 'Dynamic plank exercise targeting core and cardio',
    imageUrl: 'assets/exercises/mountain climbers.jpg',
    sets: 3,
    reps: '30 sec',
    restSeconds: 45,
    equipment: 'None',
    targetMuscles: ['Core', 'Shoulders'],
  ),
];

final List<Exercise> advancedExercises = [
  Exercise(
    name: 'Plyometric Push-ups',
    description: 'Explosive push-ups with hands leaving the ground',
    imageUrl: 'assets/exercises/Plyometric_Pushups.jpg',
    sets: 4,
    reps: '10-12',
    restSeconds: 90,
    equipment: 'None',
    targetMuscles: ['Chest', 'Shoulders', 'Triceps'],
  ),
  Exercise(
    name: 'Burpees',
    description: 'Full-body exercise combining push-ups and jumps',
    imageUrl: 'assets/exercises/burpees.jpg',
    sets: 4,
    reps: '15',
    restSeconds: 60,
    equipment: 'None',
    targetMuscles: ['Full Body'],
  ),
  Exercise(
    name: 'Diamond Push-ups',
    description: 'Close-grip push-ups with hands forming a diamond shape',
    imageUrl: 'assets/exercises/diamond_push_up.jpg',
    sets: 4,
    reps: '12-15',
    restSeconds: 60,
    equipment: 'None',
    targetMuscles: ['Chest', 'Triceps'],
  ),
];

class ExerciseListScreen extends StatelessWidget {
  final String difficulty;
  final List<Exercise> exercises;

  const ExerciseListScreen({
    super.key,
    required this.difficulty,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('$difficulty Exercises'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return ExerciseCard(
            exercise: exercises[index], onTap: () {  },
          );
        },
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCard({
    super.key,
    required this.exercise, required Null Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E2746),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              exercise.imageUrl,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  exercise.description,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildDetailItem('Sets:', exercise.sets.toString()),
                    const SizedBox(width: 16),
                    _buildDetailItem('Reps:', exercise.reps),
                    const SizedBox(width: 16),
                    _buildDetailItem('Rest:', '${exercise.restSeconds} sec'),
                  ],
                ),
                const SizedBox(height: 8),
                _buildDetailItem('Equipment:', exercise.equipment),
                const SizedBox(height: 8),
                _buildDetailItem(
                  'Target muscles:',
                  exercise.targetMuscles.join(', '),
                  textColor: Colors.blue,
                ),
                const SizedBox(height: 16),
                const WorkoutTimer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, {Color? textColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class WorkoutTimer extends StatefulWidget {
  const WorkoutTimer({super.key});

  @override
  State<WorkoutTimer> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  int _seconds = 0;
  bool _isRunning = false;
  bool _isCompleted = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _isCompleted = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
      _isCompleted = false;
    });
  }

  void _completeExercise() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isCompleted = true;
    });
  }

  String _formatTime() {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _formatTime(),
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        if (_isCompleted)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _resetTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh),
                    SizedBox(width: 4),
                    Text('Reset'),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              const SizedBox(width: 4),
              const Text(
                'Completed!',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning ? Colors.amber : Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                      // const SizedBox(width: 2),
                      // Text(_isRunning ? 'Pause' : 'Start'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh),
                      // SizedBox(width: 2),
                      // Text('Reset'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _completeExercise,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check),
                      // SizedBox(width: 2),
                      // Text('Done'),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
