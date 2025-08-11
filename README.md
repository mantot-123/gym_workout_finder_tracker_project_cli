# Gym Workout Finder App
## by mantot_123
### Why did I make this app?
Gym and weightlifting are 2 things that I've been getting into recently. So I figured out to myself, why not make an app that makes it easy for me to find new workouts that I could try out instead of doing the same old ones everyday?

I've also been learning Dart, asynchronous libraries and how to use APIs in the process of making this app, so this has been an experience for me. Who knows, I might remake this app or even make something better when I eventually think about using Flutter!

### How it works

The app fetches the available exercises using the ExerciseDB API from RapidAPI, allowing you to search for an exercise by name, target muscles and equipment

### Dependencies
* The latest version of Dart (I used 3.8.1 to write this project)
* HTTP 1.4.0 or later (https://pub.dev/packages/http)
* A command line (e.g. Windows Powershell/Command Prompt on Windows or Terminal on Linux/Mac)
* An API key to get access to the ExerciseDB API. You can get one here: https://rapidapi.com/justin-WFnsXH_t6/api/exercisedb

### API key
To set up the API key, create a new file from the project's root directory called `apiKey.txt` and simply put your new API key there. 

### How to run
To start running this program, go to your operating system's command line and run this command:

```
dart run bin/main.dart
```

### "Search" (search for an exercise)

You can search for an exercise based on the attribute  that you want from it. The program currently allows you to search for exercises by one of these attributes: name, target muscle and equipment.

Once the list of exercises are shown, you can select from one of them to view its full details, like how the exercise works and how to do it.

### "Saved" (view your saved exercises)
 
You can also view exercises that you've previously saved so you can access them quicker without having to look for them again in the search menu. They are stored locally in a file, so even if you are offline, you can still access them.