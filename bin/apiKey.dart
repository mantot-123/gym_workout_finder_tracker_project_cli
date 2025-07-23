import "dart:io";

String getApiKey() {
  File file = File("apiKey.txt");
  return file.readAsStringSync();
}