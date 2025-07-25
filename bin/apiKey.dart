import "dart:io";

String getApiKey() {
  File file = File("apiKey.txt");

  // Automatically create the file if it doesn't exist
  if(!file.existsSync()) {
    file.createSync();
  }

  return file.readAsStringSync();
}