class ActivityData {
  final double distanceKm;
  final double calories;

  ActivityData(this.distanceKm, this.calories);
}

double _calculateStepLength(double heightCm, String gender) {
  return (gender == 'male' ? heightCm * 0.415 : heightCm * 0.413) / 100;
}

ActivityData calculateDistanceAndCalories({
  required int steps,
  required double heightCm,
  required double weightKg,
  required String gender,
  double walkingSpeed = 5.0,
  double met = 3.5,
}) {
  double stepLength = _calculateStepLength(heightCm, gender); // in meters
  double distanceKm = (steps * stepLength) / 1000;
  double durationHours = distanceKm / walkingSpeed;
  double calories = met * weightKg * durationHours;
  return ActivityData(distanceKm, calories);
}