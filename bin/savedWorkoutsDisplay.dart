import "dart:io";
import "workoutsDisplay.dart";
import "savedWorkoutsFile.dart";
import "helpers.dart" as helpers;

class SavedWorkoutsDisplay extends WorkoutsDisplay {
  SavedWorkoutsDisplay(List<dynamic> workouts) : super(workouts);

  // Removes the workout then refreshes the workouts list with the new contents from the saved workouts file
  void removeWorkoutRefreshList(var workout) {
    savedWorkoutsFile.removeFromSavedList(workout);
    savedWorkoutsFile.writeFile();
    savedWorkoutsFile.readFile();
    workouts = savedWorkoutsFile.savedWorkouts;
  }

  @override
  void promptUserWorkoutActions(var workout) {
    showFullWorkoutInfo(workout);
    while(true) {
      print("What do you want to do with this exercise?\n'remove' = Removes this exercise from the saved list\n'back' = Go back to the previous page");
      String? command = stdin.readLineSync() ?? "";
      switch(command.toLowerCase()) {
        case "remove":
          removeWorkoutRefreshList(workout);
          return;
        case "back":
          return;
        default:
          print("You have entered an invalid command. Please try again.");
      }
    }
  }
}