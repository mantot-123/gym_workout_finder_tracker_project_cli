import "dart:io";
import "savedWorkoutsFile.dart";
import "helpers.dart" as helpers;

class WorkoutsDisplay {
  List<dynamic> workouts = [];
  SavedWorkoutsFile savedWorkoutsFile = SavedWorkoutsFile();

  // CONSTRUCTOR METHOD
  WorkoutsDisplay(this.workouts);

  Map<String, dynamic> getWorkoutById(String id, [List<dynamic>? fromList]) {
    // if(fromList == null) {
    //   fromList = workouts;
    // }
    fromList ??= workouts; // If the "fromList" is null, give it the "workouts" list

    for(Map<String, dynamic> workout in fromList) {
      if(workout["id"] == id)  {
        return workout;
      }
    }
    return {};

  }

  void displayWorkoutsList() {
    int counter = 1;
    if(workouts.isEmpty) {
      print("Sorry, there are currently no workouts available.");
      return;
    }

    while(true) {
      workouts.forEach((workout) {
        print("--------------------------------------------");
        print("(${counter})");
        print("Name: ${workout["name"]}");
        print("Target: ${workout["target"]}");
        print("Equipment required: ${workout["equipment"]}");
        print("ID: ${workout["id"]}");
        counter++;
      });
      
      print("Select the workout you want by entering its ID (type 'back' to go back to the target muscles menu): ");
      String? selectedId = stdin.readLineSync() ?? "";
      
      if(selectedId != "") {
        if(selectedId.toLowerCase() == "back") {
          return;
        }

        var result = getWorkoutById(selectedId);
        if(result.isEmpty) {  
          print("The exercise you're looking for does not exist. Try finding another exercise.");
          continue;
        }

        promptUserWorkoutActions(result);
        counter = 1;
    
      } else {
        print("Please enter an exercise ID.");
      }
    }
  }

  void showFullWorkoutInfo(var workout) {
    print("--------------------------------------------");
    print("Full workout info for ID ${workout["id"]}:");
    print("--------------------------------------------");
    print("Name: ${workout["name"]}");
    print("Target: ${workout["target"]}");
    print("Secondary muscles:");
    for(int i = 0; i < workout["secondaryMuscles"].length; i++) {
      print("(${i + 1}) ${workout["secondaryMuscles"][i]}");
    }

    print("Equipment required: ${workout["equipment"]}");
    print("Difficulty: ${workout["difficulty"]}");
    print("Category: ${workout["category"]}");
    print("Description: ${workout["description"]}");
    print("Instructions:");
    helpers.printListNumbered(workout["instructions"]);
    print("--------------------------------------------");
  }

  void promptUserWorkoutActions(var workout) {
    showFullWorkoutInfo(workout);
    while(true) {
      print("What do you want to do with this exercise?\n'save' = Save this exercise to your list\n'back' = Go back to the list");
      String? command = stdin.readLineSync() ?? "";
      switch(command.toLowerCase()) {
        case "save":
          savedWorkoutsFile.addToSavedList(workout);
          savedWorkoutsFile.writeFile();
          print("Exercise successfully saved!");
          return;
        case "back":
          return;
        default:
          print("You have entered an invalid command. Please try again.");
      }
    }
  }
}