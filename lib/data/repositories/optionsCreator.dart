class optionsCreator {
  List<List<List<int>>> options = [];
  int lineSize = 9;
  String ErrorMessage = "";

  optionsCreator(List<String> rawInput) {
    transformToOptions(rawInput);
    checkForErrors();
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

  String? checkForErrors() {
    int? doubleNumber = null;
    int? lineOfError = null;
    for (int i = 0; i < options.length; i++) {
      List<List<int>> line = options[i];
      List<int> numbers = [];
      for (int j = 0; j < line.length; j++) {
        List<int> field = line[j];
        if (field.length == 1 && field.first != 0) {
          numbers.add(field.first);
        }
      }
      int? duplicate = checkDoubelingNumber(numbers);
      if (duplicate != null) {
        doubleNumber = duplicate;
        lineOfError = i + 1;
      }
    }

    if (doubleNumber != null && lineOfError != null) {
      return "Error: $doubleNumber appears twice in Line $lineOfError";
    }

    return null;
  }



  //check if the Same Number Appears twice in row
  int? checkDoubelingNumber(List<int> numbers) {
    for(int i = 0; i < numbers.length; i++){
      int toTest = numbers[i];
      for(int j = 0; j < numbers.length; j++){
        if(toTest == numbers[j] && i != j){
          return toTest;
        }
      }
    }
    return null;
  }
}
