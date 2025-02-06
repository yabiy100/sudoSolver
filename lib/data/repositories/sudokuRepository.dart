import 'package:sudoku_solver/data/repositories/solver.dart';

class SudokuRepository {
  final Solver firstSudoku = Solver([
    "405678000",
    "978321456",
    "601095703",
    "200086900",
    "896714035",
    "007032640",
    "504203007",
    "309847010",
    "000050300",
  ]);

  List<List<List<int>>> getOptions() {
    firstSudoku.solveSudoku();
    return firstSudoku.getOptions();
  }
}
