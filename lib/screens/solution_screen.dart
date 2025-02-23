import "package:flutter/material.dart";
import "package:sudoku_solver/data/repositories/solver.dart";


class SolutionScreen extends StatelessWidget {
  final Solver sudoku;

  const SolutionScreen({super.key, required this.sudoku});

  @override
  Widget build(BuildContext context) {
    sudoku.solveSudoku();
    List<int> flatSudoku = sudoku.getGrid().expand((row) => row).toList();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Solution to Sudoku"),
          backgroundColor: const Color(0xffE29A4C),
        ),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 9,
            childAspectRatio: 1,
          ),
          itemCount: 81,
          itemBuilder: (context, index) {
            int field = flatSudoku[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1.0)),
                    alignment: Alignment.center,
              child: Text(
                field.toString(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
    );
  }
}
