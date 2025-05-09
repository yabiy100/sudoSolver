class solvingTechniques {
  List<List<int>>? grid = [];
  List<List<List<int>>> options = [];
  int lineSize = 9;
  bool changed = true;

  solvingTechniques(this.options);

  void printOptions() {
    for (List<List<int?>> line in options) {
      print(line);
    }
  }

  List<List<int>>? getGrid(){
    return grid;
  }

  List<List<List<int>>> getOptions(){
    return options;
  }

  void printGrid() {
    for (List<int?> line in grid!) {
      print(line);
    }
  }

}