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
        child: AspectRatio(
          aspectRatio: 1, //Sqaure grid 1:1
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
                  border: Border( //make borders of 3 x 3 Cells bigger
                    top: BorderSide(width: (index < 9) ? 5 : 1.0, color: Colors.black),
                    //draw 3 vertical lines left one and the two in the middle
                    left: BorderSide(width: (index % 9 == 0 || index % 9 == 3 || index % 9 == 6)
                        ? 5 : 1.0, color: Colors.black),
                    right: BorderSide(width: ((index + 1) % 9 == 0) ? 5 : 1.0, color: Colors.black),
                    //draw 3 horizontal lines: 3.row, 6.row and last row
                    bottom: BorderSide(width: (index >= 72 || (index > 17 && index < 27)
                    || (index > 44 && index < 54)) ? 5 : 1.0, color: Colors.black),
                  ),
                color: Colors.white,
                ),
                alignment: Alignment.center,
                child: Text(
                  field.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        )
      ),
    );
  }
}
