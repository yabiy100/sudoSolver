import 'package:sudoku_solver/data/repositories/simpleReduction.dart';

import 'optionsCreator.dart';

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
    simpleReduction reduction = new simpleReduction(options);
    options = reduction.doReduction();
    if (OptionsAllSolved()) {
      writeOptionsToGrid();
    } else {
      grid = null;
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
      for (List<int> field in line) {
        if(field.length != 1){
          return false;
        }
      }
    }
    return true;
  }

  List<List<int>>? getGrid(){
    return grid;
  }

  List<List<List<int>>> getOptions(){
    return options;
}

}