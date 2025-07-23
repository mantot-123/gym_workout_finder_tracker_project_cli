import "search.dart";
import "helpers.dart" as helpers;
import "savedWorkoutsFile.dart";
import "workoutsDisplay.dart";
import "dart:io";

Future<void> promptUserTargetMuscle() async {
  Search search = Search();
  List<dynamic> muscles = await search.getData("targetList");

  while(true) {
    print("--------------------------------------------");
    print("Here are all the available target muscles you can select from:");
    helpers.printListNumbered(muscles);
    print("Enter the target muscle for your exercise (type 'menu' to go back to the main menu):");

    String? targetMuscle = stdin.readLineSync();
    if(targetMuscle != null) {
      if(targetMuscle.toLowerCase() == "menu") {
        print("Taking you back to the main menu...");
        return;
      }

      if(muscles.contains(targetMuscle.toLowerCase())) {
          List<dynamic> workouts = await search.getData("target", targetMuscle);
          WorkoutsDisplay workoutsDisplay = WorkoutsDisplay(workouts);
          workoutsDisplay.displayWorkoutsList();
      } else {
          print("Please enter a valid target muscle");
      }

    }
  }
}


Future<void> promptUserExerciseName() async {
  Search search = Search();
  while(true) {
    print("What name of exercise are you looking for? (Type 'menu' to go back to the main menu)");
    String? exerciseName = stdin.readLineSync();
    if(exerciseName != null) {
      if(exerciseName.toLowerCase() == "menu") {
        return;
      }

      List<dynamic> workouts = await search.getData("name", exerciseName);
      WorkoutsDisplay workoutsDisplay = WorkoutsDisplay(workouts);
      workoutsDisplay.displayWorkoutsList();
    }
  }
}


Future<void> promptUserExerciseEquipment() async {
  Search search = Search();
  List<dynamic> equipmentList = await search.getData("equipmentList");

  while(true) {
    print("--------------------------------------------");
    print("Here are all the available gym equipment you can use");
    helpers.printListNumbered(equipmentList);
    print("Enter the equipment you want to use for your exercise (type 'menu' to go back to the main menu):");

    String? chosenEq = stdin.readLineSync();
    if(chosenEq != null) {
      if(chosenEq.toLowerCase() == "menu") {
        print("Taking you back to the main menu...");
        return;
      }

      if(equipmentList.contains(chosenEq.toLowerCase())) {
          List<dynamic> workouts = await search.getData("equipment", chosenEq);
          WorkoutsDisplay workoutsDisplay = WorkoutsDisplay(workouts);
          workoutsDisplay.displayWorkoutsList();
      } else {
          print("Please select a valid equipment.");
      }

    }
  }
}


Future<void> promptUserSearchOption() async {
  while(true) {
    print("--------------------------------------------");
    print("How do you want to find your workout?\n'name' - Search by name\n'target' - Search by target muscle\n'equipment' - Search by equipment\nTo leave, type 'menu'");
    String? attr = stdin.readLineSync();
    if(attr != null) {
      switch(attr.toLowerCase()) {
        case "name":
          await promptUserExerciseName();
        case "target":
          await promptUserTargetMuscle();
        case "equipment":
          await promptUserExerciseEquipment();
        case "menu":
          return;
      }
    }
  }
}

void viewSavedWorkouts() {
  // TODO WORK ON SAVED WORKOUTS VIEWER
  return;
}

void main() async {
  while(true) {
    print("--------------------------------------------");
    print("Gym Workout Finder\nWhat do you want to do?\n'search' - Find a workout\n'saved' - View and manage your saved workouts\n'exit' - Leave the program");
    String? command = stdin.readLineSync();
    if(command != null) {
      switch(command.toLowerCase()) {
        case "search":
          await promptUserSearchOption();
        case "saved":
          viewSavedWorkouts();
        case "exit":
          return;
        default:
          print("You have entered an invalid command. Please try again.");
      }
    }
  }
}