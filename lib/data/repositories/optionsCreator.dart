class optionsCreator {
  List<List<List<int>>> options = [];
  int lineSize = 9;

  optionsCreator(List<String> rawInput) {
    transformToOptions(rawInput);
  }

  void transformToOptions(List<String> rawInput) {
    for (String line in rawInput) {
      List<List<int>> lineToAdd = [];
      //Create Line with lists that only consists of zeros
      if (line.isEmpty) {
        for (int i = 0; i < lineSize; i++) {
          lineToAdd.add([0]);
        }
        //transform the Numbers into Lists with one element
      } else {
        for (int i = 0; i < lineSize; i++) {
          List<int> oneField = [int.parse(line[i])];
          lineToAdd.add(oneField);
        }
      }
      options.add(lineToAdd);
    }
  }

  List<List<List<int>>> getOptions() {
    return options;
  }
}
