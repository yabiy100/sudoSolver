import "package:flutter/material.dart";
import "package:sudoku_solver/data/repositories/solver.dart";

class SolutionScreen extends StatelessWidget {
  final Solver sudoku;

  const SolutionScreen({super.key, required this.sudoku});

  @override
  Widget build(BuildContext context) {
    sudoku.solveSudoku();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku Solution'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sudoku.getGrid().map((line) {
            return Text(line.toString());
          }).toList(),
        ),
      ),
    );
  }
}
