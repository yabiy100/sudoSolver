import 'package:flutter/material.dart';
import 'package:sudoku_solver/data/repositories/solver.dart';
import 'package:sudoku_solver/screens/input_screen.dart';
import 'package:sudoku_solver/screens/solution_screen.dart';

void main() {
  /* test Sudoku for solution Screen
  Solver testSudoku = Solver([
    "003009267",
    "090860000",
    "201500400",
    "900401080",
    "076000130",
    "010607009",
    "009005603",
    "000094010",
    "835700900",
  ]);
  testSudoku.solveSudoku();
  runApp(MaterialApp(
    home: SolutionScreen(sudoku: testSudoku),
    theme: new ThemeData(scaffoldBackgroundColor: Colors.blue),
  ));
  */
  runApp(MaterialApp(
    home: InputScreen(),
  ));
}

