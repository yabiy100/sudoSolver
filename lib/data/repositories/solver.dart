class Solver {
  List<List<int>> grid = [];
  int lineSize = 9;
  List<List<int>> solvedGrid = [];
  List<List<List<int>>> options = [];
  bool changed = true;

  Solver(List<String> rawInput){
    transformToGrid(rawInput);
  }

  void transformToGrid(List<String> rawInput) {
    for(String line in rawInput){
      List<int> intLine = [];
      if(line.isEmpty){
        intLine = List.filled(9, 0); // fill empty line with 9 times 0
        grid.add(intLine);
      }else {
        //Analyze each Character of each Line
        transformEachNumber(line, intLine);
      }
    }
  }

  void transformEachNumber(String line, List<int> intLine) {
    for(int i = 0; i < lineSize; i++){
      if(line[i] == "0"){
        intLine.add(0);
      }else{
        intLine.add(int.parse(line[i]));
      }
    }
    grid.add(intLine);
  }
  void calculateAllOptionens(){
    while(changed == true){
      changed = false;
      calculateLine();
      calculateColumn();
      calculateSquare();
    }
  }



  void calculateLine() {
    for (int row = 0; row < lineSize; row++) {
      for (int col = 0; col < lineSize; col++) {
        List<int> field = options[row][col];
        //If field is empthy calculate remaining options in line
        if(field.first == 0){
          changed = true;
          field.remove(0);
          List<int> allNumbers = [1,2,3,4,5,6,7,8,9];
          for(int i = 0; i < lineSize; i++){
            if(options[row][i].length == 1){
              allNumbers.remove(options[row][i].first);
            }
          }
          options[row][col] = allNumbers;
        }
      }
    }
  }


  void calculateColumn() {
    for (int col = 0; col < lineSize; col++) {
      List<int> columnNumbers = getColumn(col);
      for (int row = 0; row < lineSize; row++) {
        List<int> field = options[row][col];
        if (field.first == 0 || field.length > 1) {
          changed = true;
          field.remove(0);
          List<int> allNumbers = options[row][col];
          // Remove numbers already present in the column
          for (int num in columnNumbers) {
            allNumbers.remove(num);
          }
          options[row][col] = allNumbers;
        }
      }
    }
  }
  //calculates which nummbers in a 3 by 3 Block cancel out the options
  void calculateSquare() {
    for(int row = 0; row < lineSize; row = row + 3 ){
      for(int col = 0; col < lineSize; col = col + 3){
        calculateOneSqaure(row,col);
      }
    }
  }

  void calculateOneSqaure(int sqaureRow, sqaureCol) {
    List<int> squareNumbers = findNumbersInSqaure(sqaureRow, sqaureCol);
    for(int row = sqaureRow; row < sqaureRow + 3; row++){
      for(int col = sqaureCol; col < sqaureCol + 3; col++){
        List<int> field = options[row][col];
        if(field.length > 1){
          changed = true;
          List<int> allNumbers = options[row][col];
          //all Numbers that are already set in a sqaure;
          for (int num in squareNumbers) {
            if (num != 0) {
              allNumbers.remove(num);
            }
          }
          options[row][col] = allNumbers;
        }
      }
    }
  }

  // Helper method to get a column by index
  List<int> getColumn(int colIndex) {
    List<int> column = [];
    for (int row = 0; row < lineSize; row++) {
      column.add(grid[row][colIndex]);
    }
    return column;
  }

  List<int> findNumbersInSqaure(int startRow, int startCol) {
    List<int> sqaure = [];
    for (int row = startRow; row < startRow + 3; row++) {
      for (int col = startCol ; col < startCol + 3; col++) {
        if (options[row][col].length == 1) {
          sqaure.add(options[row][col].first);
        }
      }
    }
    return sqaure;
  }

    void copyStartGridToOptions() {
      for (List<int> line in grid) {
        List<List<int>> lineToAdd = [];
        for (int number in line) {
          List<int> oneField = [number];
          lineToAdd.add(oneField);
        }
        options.add(lineToAdd);
      }
    }

    void printGrid() {
      for (List<int?> line in grid) {
        print(line);
      }
    }

    List<List<int?>> getField() {
      return grid;
    }

    List<List<List<int?>>> getOptions() {
      return options;
    }

    void printOptions() {
      for (List<List<int?>> line in options) {
        print(line);
      }
    }
  }