import "dart:io";
import "helpers.dart" as helpers;

class WorkoutsDisplay {
  List<dynamic> workouts = [];

  // CONSTRUCTOR METHOD
  WorkoutsDisplay(this.workouts);

  Map<String, dynamic> getWorkoutById(String? id) {
    for(Map<String, dynamic> workout in workouts) {
      if(workout["id"] == id)  {
        return workout;
      }
    }
    return {};
  }

  void displayWorkoutsList() {
    int counter = 1;
    if(workouts.isEmpty) {
      print("Sorry, there are no workouts that match your criteria.");
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
      String? selectedId = stdin.readLineSync();
      if(selectedId != null) {
        if(selectedId != "") {
          if(selectedId.toLowerCase() == "back") {
            return;
          }

          var result = getWorkoutById(selectedId);
          if(result.isEmpty) {  
            print("The exercise you're looking for does not exist. Try finding another exercise.");
            continue;
          }

          showFullWorkoutInfo(result);
      
        } else {
          print("Please enter an exercise ID.");
        }
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
    while(true) {
      print("What do you want to do with this exercise?\n'save' = Save this exercise to your list\n'back' = Go back to the list");
      String? command = stdin.readLineSync();
      if(command != null) {
        switch(command.toLowerCase()) {
          case "save":
            // TODO SAVE FUNCTIONALITY HERE
            print("Save functionality has not ben implemented yet. Please check back later.");
          case "back":
            return;
          default:
            print("You have entered an invalid command. Please try again.");
        }
      }
    }
  }
}