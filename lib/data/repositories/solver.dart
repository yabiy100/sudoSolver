class Solver {
  List<List<int?>> grid = [];
  int lineSize = 9;
  List<List<int?>> solvedGrid = [];
  List<List<List<int?>>> options = [];

  Solver(List<String> rawInput){
    transformToGrid(rawInput);
    copyStartGridToOptions();
  }

  void transformToGrid(List<String> rawInput) {
    for(String line in rawInput){
      List<int?> intLine = [];
      if(line.isEmpty){
        intLine = List.filled(9, null); // fill empty line with 9 times null
        grid.add(intLine);
      }else {
        //Analyze each Character of each Line
        transformEachNumber(line, intLine);
      }
    }
  }

  void transformEachNumber(String line, List<int?> intLine) {
    for(int i = 0; i < lineSize; i++){
      if(line[i] == " " || line[i] == "."){
        intLine.add(null);
      }else{
        intLine.add(int.parse(line[i]));
      }
    }
    grid.add(intLine);
  }
  void solveGrid(){

    //find out which Number isnt used in a line and save them
    //in every empty field
    for(List<List<int?>> line in options){
      List<int?> allNumbers = [0,1,2,3,4,5,6,7,8,9];
      calculateOptionsInLine(allNumbers);
      for(List<int?> field in line){
        if(field.isNotEmpty){
          field.addAll(allNumbers);
        }
      }
    }


  }

  void calculateOptionsInLine(List<dynamic> allNumbers) {
    // Copy over the numbers of the grid to the options
    // Leave fields empty that have no number
    for(List<int?> field in grid){
      int? number = field.firstOrNull;
      if(number != null){
        allNumbers.remove(number);
      }
    }
  }

  void copyStartGridToOptions() {
    // the
    for(List<int?> line in grid){
      List<List<int?>> lineToAdd = [];
      for(int? number in line){
        List<int?> oneField = [number];
        lineToAdd.add(oneField);
      }
      options.add(lineToAdd);

    }
  }

  void printGrid(){
    for(List<int?> line in grid){
      print(line);
    }
  }

  List<List<int?>> getField() {
    return grid;
  }

  List<List<List<int?>>> getOptions(){
    return options;
  }


}