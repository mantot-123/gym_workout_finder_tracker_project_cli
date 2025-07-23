void printListNumbered(List<dynamic> ls) {
  for(int i = 0; i < ls.length; i++) {
    print("${i + 1}.) ${ls[i]}");
  }
}