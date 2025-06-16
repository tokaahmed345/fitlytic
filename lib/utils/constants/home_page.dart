// Add a timer for periodic UI updates
import 'dart:async';

Timer? updateTimer;
int lastRecordedSteps = 0;
DateTime lastStepTime = DateTime.now();
DateTime lastStepsSaveTime = DateTime.now();
