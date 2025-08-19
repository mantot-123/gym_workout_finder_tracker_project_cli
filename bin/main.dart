import "apiKey.dart";
import "search.dart";
import "helpers.dart" as helpers;
import "savedWorkoutsFile.dart";
import "workoutsDisplay.dart";
import "savedWorkoutsDisplay.dart";
import "dart:io";

Future<void> promptUserTargetMuscle() async {
  Search search = Search();
  List<dynamic> muscles = await search.getData("targetList");

  while(true) {
    print("--------------------------------------------");
    print("Here are all the available target muscles you can select from:");
    helpers.printListNumbered(muscles);
    print("Enter the target muscle for your exercise (type 'prev' to go back to the previous page):");

    String targetMuscle = stdin.readLineSync() ?? "";

    if(targetMuscle.toLowerCase() == "prev") {
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


Future<void> promptUserExerciseName() async {
  Search search = Search();
  while(true) {
    print("What name of exercise are you looking for? (Type 'back' to go back to the previous page)");
    String? exerciseName = stdin.readLineSync() ?? "";

    if(exerciseName.toLowerCase() == "back") {
      return;
    }

    List<dynamic> workouts = await search.getData("name", exerciseName);
    WorkoutsDisplay workoutsDisplay = WorkoutsDisplay(workouts);
    workoutsDisplay.displayWorkoutsList();
  }
}


Future<void> promptUserExerciseEquipment() async {
  Search search = Search();
  List<dynamic> equipmentList = await search.getData("equipmentList");

  while(true) {
    print("--------------------------------------------");
    print("Here are all the available gym equipment you can use");
    helpers.printListNumbered(equipmentList);
    print("Enter the equipment you want to use for your exercise (type 'back' to go back to the previous page):");

    String? chosenEq = stdin.readLineSync() ?? "";

    if(chosenEq.toLowerCase() == "back") {
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


Future<void> promptUserSearchOption() async {
  while(true) {
    print("--------------------------------------------");
    print("How do you want to find your workout?\n'name' - Search by name\n'target' - Search by target muscle\n'equipment' - Search by equipment\nTo leave, type 'menu'");
    String? attr = stdin.readLineSync() ?? "";
    switch(attr.toLowerCase()) {
      case "name":
        await promptUserExerciseName();
        break;
      case "target":
        await promptUserTargetMuscle();
        break;
      case "equipment":
        await promptUserExerciseEquipment();
        break;
      case "menu":
        return;
    }
  }
}


Future<void> viewSavedWorkouts() async {
  SavedWorkoutsFile savedWorkoutsFile = SavedWorkoutsFile();

  print("Do you want to update your saved workouts before viewing them? (type 'Y' for yes, you can leave this blank or type something else if no)");
  String? updateConfirm = stdin.readLineSync();
  
  if(updateConfirm == null) {
    return;
  }

  if(updateConfirm.toLowerCase() == "y") {
    print("Getting all the saved workouts for you...");
    await savedWorkoutsFile.updateSavedWorkouts();
  }

  SavedWorkoutsDisplay workoutsDisplay = SavedWorkoutsDisplay(savedWorkoutsFile.savedWorkouts);
  print("Here are all your saved workouts:");
  workoutsDisplay.displayWorkoutsList();
}


void main() async {
  if(getApiKey() == "") {
    print("ERROR: Please set your ExerciseDB API key in the \"apiKey.txt\" before running the program.");
    return;
  }

  while(true) {
    print("--------------------------------------------");
    print("Gym Workout Finder\nWhat do you want to do?\n'search' - Find a workout\n'saved' - View and manage your saved workouts\n'exit' - Leave the program");
    String? command = stdin.readLineSync() ?? "";
    switch(command.toLowerCase()) {
      case "search":
        await promptUserSearchOption();
      case "saved":
        await viewSavedWorkouts();
      case "exit":
        return;
      default:
        print("You have entered an invalid command. Please try again.");
    }
  }
}