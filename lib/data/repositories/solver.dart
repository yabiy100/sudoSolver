import 'package:sudoku_solver/data/repositories/optionsCreator.dart';

class Solver {
  List<List<int>>? grid = [];
  List<List<List<int>>> options = [];
  int lineSize = 9;
  bool changed = true;

  Solver(List<String> rawInput) {
    optionsCreator creator = optionsCreator(rawInput);
    this.options = creator.getOptions();
  }

  void solveSudoku() {
    while (changed == true) {
      changed = false;
      calculateLine();
      calculateColumn();
      calculateSquare();
    }
    if(OptionsAllSolved()){
      writeOptionsToGrid();
    } else{
      grid = null;
    }

  }

  void calculateLine() {
    for (int row = 0; row < lineSize; row++) {
      for (int col = 0; col < lineSize; col++) {
        List<int> field = options[row][col];
        //If field is empty calculate remaining options in line
        if (field.first == 0) {
          changed = true;
          field.remove(0);
          List<int> allNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
          removeLineNumbers(row, allNumbers);
          options[row][col] = List.from(allNumbers);
          // Options field has more than one possible Number
        } else if (field.length > 1) {
          changed = true;
          List<int> allNumbers = List.from(field);
          removeLineNumbers(row, allNumbers);
          options[row][col] = List.from(allNumbers);
        }
      }
    }
  }

  void removeLineNumbers(int row, List<int> allNumbers) {
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

  //calculates which numbers in a 3 by 3 Block cancel out the options
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

  //return a list with all set Numbers in a 3x3 Sudoku Square
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
    for (List<int?> line in grid!) {
      print(line);
    }
  }

  List<List<int>>? getGrid() {
    return grid;
  }

  List<List<List<int>>> getOptions() {
    return options;
  }

  void printOptions() {
    for (List<List<int?>> line in options) {
      print(line);
    }
  }

  void writeOptionsToGrid() {
    for (List<List<int>> line in options) {
      List<int> gridLine = [];
      for (List<int> field in line) {
        gridLine.add(field.first);
      }
      grid?.add(gridLine);
    }
  }

  bool OptionsAllSolved() {
    for (List<List<int>> line in options) {
      List<int> gridLine = [];
      for (List<int> field in line) {
        if(field.length != 1){
          return false;
        }
      }
    }
    return true;
  }
}