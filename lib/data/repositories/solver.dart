class Solver {
  List<List<int?>> grid = [];
  int lineSize = 9;
  List<List<int?>> solvedGrid = [];
  List<List<List<int?>>> options = [];

  Solver(List<String> rawInput){
    transformToGrid(rawInput);
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
  void calculateAllOptionens(){
    //find out which Number isnt used in a line and save them
    //in every empty field
    //printGrid();
    //printOptions();
    analyzeLine();
    analyzeColumn();
  }

  void analyzeLine() {
    for(List<List<int?>> line in options){
      for(List<int?> field in line){
        if(field.first == null){
          field.remove(null);
          List<int?> allNumbers = [1,2,3,4,5,6,7,8,9];
          //remove all numbers that are in a line to get remaining options
          for(List<int?> fullfield in line){
            if(fullfield.length == 1){
              allNumbers.remove(fullfield.first);
            }
          }
          field.addAll(allNumbers);
        }
      }
    }
  }


  void analyzeColumn() {
    for (int col = 0; col < lineSize; col++) {
      List<int?> columnNumbers = getColumn(col);
      for (int row = 0; row < lineSize; row++) {
        List<int?> field = options[row][col];
        if (field.first == null) {
          field.remove(null);
          List<int?> allNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
          // Remove numbers already present in the column
          for (int? num in columnNumbers) {
            if (num != null) {
              allNumbers.remove(num);
            }
          }
          field.addAll(allNumbers);
        }
        if(field.length > 1){
          List<int?> allNumbers = options[row][col];
          for (int? num in columnNumbers) {
            if (num != null) {
              allNumbers.remove(num);
            }
          }
        }
      }
    }
  }

  // Helper method to get a column by index
  List<int?> getColumn(int colIndex) {
    List<int?> column = [];
    for (int row = 0; row < lineSize; row++) {
      column.add(grid[row][colIndex]);
    }
    return column;
  }

  void copyStartGridToOptions() {
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

  void printOptions() {
    for(List<List<int?>> line in options){
      print(line);
    }
  }


}