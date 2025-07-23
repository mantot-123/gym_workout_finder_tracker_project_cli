import "dart:io";
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import "workout.dart";
import "apiKey.dart";

class Search {
    // Gets the URI object based on the workout attribute selected and data passed to it
  Uri getUri([String attribute = "", String value = ""]) {
    Uri? url;

    switch(attribute) {
      case "name":
        url = Uri.https("exercisedb.p.rapidapi.com", "/exercises/name/${value}");
      case "bodyPart":
        url = Uri.https("exercisedb.p.rapidapi.com", "/exercises/bodyPart/${value}");
      case "target":
        url = Uri.https("exercisedb.p.rapidapi.com", "/exercises/target/${value}");
      case "targetList":
        url = Uri.https("exercisedb.p.rapidapi.com", "/exercises/targetList");
      case "equipmentList":
        url = Uri.https("exericsedbv.p.rapidapi.com", "/exercises/equipmentList");
      default:
        url = Uri.https("exercisedb.p.rapidapi.com", "/exercises/"); // By default, the API should respond back with some first few exercises it receives
    }
    return url;
  }

  Future<List<dynamic>> getData([String attribute = "", String data = ""]) async {
    Uri url = getUri(attribute, data);
    http.Response response = await http.get(
      url,
      headers: {
        "x-rapidapi-key": getApiKey(),
        "x-rapidapi-host" : "exercisedb.p.rapidapi.com"
      });

    // Converts the JSON response into a list
    List<dynamic> dataList = convert.jsonDecode(response.body);
    return Future.value(dataList);
  }
}
