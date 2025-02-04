class Solver {
  List<List<int>> grid = [];
  List<List<List<int>>> options = [];
  int lineSize = 9;
  bool changed = true;

  Solver(List<String> rawInput) {
    transformToGrid(rawInput);
  }

  void transformToGrid(List<String> rawInput) {
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

  void solveSudoku() {
    while (changed == true) {
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
        if (field.first == 0) {
          changed = true;
          field.remove(0);
          List<int> allNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
          goTroughLine(row, allNumbers);
          options[row][col] = List.from(allNumbers);
        } else if (field.length > 1) {
          changed = true;
          List<int> allNumbers = List.from(field);
          goTroughLine(row, allNumbers);
          options[row][col] = List.from(allNumbers);
        }
      }
    }
  }

  void goTroughLine(int row, List<int> allNumbers) {
    for (int i = 0; i < lineSize; i++) {
      if (options[row][i].length == 1) {
        allNumbers.remove(options[row][i].first);
      }
    }
  }

  void calculateColumn() {
    for (int col = 0; col < lineSize; col++) {
      for (int row = 0; row < lineSize; row++) {
        List<int> field = options[row][col];
        if (field.first == 0 || field.length > 1) {
          List<int> columnNumbers = getColumn(col);
          changed = true;
          field.remove(0);
          List<int> allNumbers = options[row][col];
          // Remove numbers already present in the column
          for (int num in columnNumbers) {
            allNumbers.remove(num);
          }
          options[row][col] = List.from(allNumbers);
        }
      }
    }
  }

  //calculates which nummbers in a 3 by 3 Block cancel out the options
  void calculateSquare() {
    for (int row = 0; row < lineSize; row = row + 3) {
      for (int col = 0; col < lineSize; col = col + 3) {
        calculateOneSqaure(row, col);
      }
    }
  }

  void calculateOneSqaure(int sqaureRow, sqaureCol) {
    List<int> squareNumbers = findNumbersInSqaure(sqaureRow, sqaureCol);
    for (int row = sqaureRow; row < sqaureRow + 3; row++) {
      for (int col = sqaureCol; col < sqaureCol + 3; col++) {
        List<int> field = options[row][col];
        if (field.length > 1) {
          changed = true;
          List<int> allNumbers = options[row][col];
          //all Numbers that are already set in a sqaure;
          for (int num in squareNumbers) {
            if (num != 0) {
              allNumbers.remove(num);
            }
          }
          options[row][col] = List.from(allNumbers);
        }
      }
    }
  }

  // Helper method to get a column by index
  List<int> getColumn(int colIndex) {
    List<int> column = [];
    for (int row = 0; row < lineSize; row++) {
      if (options[row][colIndex].length == 1) {
        column.add(options[row][colIndex].first);
      }
    }
    return column;
  }

  List<int> findNumbersInSqaure(int startRow, int startCol) {
    List<int> sqaure = [];
    for (int row = startRow; row < startRow + 3; row++) {
      for (int col = startCol; col < startCol + 3; col++) {
        if (options[row][col].length == 1) {
          sqaure.add(options[row][col].first);
        }
      }
    }
    return sqaure;
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
