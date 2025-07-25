import "dart:io";
import "dart:convert";
import "search.dart";

class SavedWorkoutsFile {
  final File jsonFile = File("workouts.json");
  List<dynamic> savedWorkouts = [];

  SavedWorkoutsFile() {
    // If the file does not exist, create it
    if(!jsonFile.existsSync()) {
      jsonFile.createSync();
    }
    readFile(); // Read the file contents into the savedWorkouts variable
  }

  void addToSavedList(var workout, [bool replaceIfAlreadyInList = false]) {
    if(replaceIfAlreadyInList) {
      for(var w in savedWorkouts) {
        if(w["id"] == workout["id"]) {
          w = workout;
          return;
        }
      }
    }
    savedWorkouts.add(workout);
  }

  void removeFromSavedList(var workout) {
    // TODO SIMPLIFY THIS CODE
    for(int i=0; i < savedWorkouts.length; i++) {
      if(savedWorkouts[i]["id"] == workout["id"]) {
        savedWorkouts.removeAt(i);
      }
    }
    print("Can't remove. The exercise does not exist in the list.");
  }


  // Loads the JSON data into a variable
  void readFile() {
    String contents = jsonFile.readAsStringSync();
    // Check if the contents of the JSON are empty
    if(contents == "" || contents == "[]") {
      return;
    }
    savedWorkouts = jsonDecode(contents);
  }


  // Writes to the file with JSON data
  void writeFile() {
    String jsonList = jsonEncode(savedWorkouts);
    jsonFile.writeAsStringSync(jsonList);
  }


  // Connects to the API to get new information about the saved workout
  Future<void> updateSavedWorkouts() async {
    Search search = Search();
    for(var workout in savedWorkouts) {
      workout = await search.getData("id", workout["id"]);
    }

    writeFile();

    print("Saved workouts successfully updated");
  }
  
}