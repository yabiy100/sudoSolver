// Import the test package and Counter class

import 'package:sudoku_solver/data/repositories/solver.dart';
import 'package:test/test.dart';

void main() {
  group("All Tests", ()
  {
    test("grid with just numbers", () {
      List<String> rawInput = [
        "123456789",
        "987654321",
        "135792468",
        "147025839",
        "123456789",
        "987654321",
        "135792468",
        "147025839",
        "019283475",
      ];
      final solver = Solver(rawInput);

      List<List<int?>> intField = [
        [1, 2, 3, 4, 5, 6, 7, 8, 9],
        [9, 8, 7, 6, 5, 4, 3, 2, 1],
        [1, 3, 5, 7, 9, 2, 4, 6, 8],
        [1, 4, 7, 0, 2, 5, 8, 3, 9],
        [1, 2, 3, 4, 5, 6, 7, 8, 9],
        [9, 8, 7, 6, 5, 4, 3, 2, 1],
        [1, 3, 5, 7, 9, 2, 4, 6, 8],
        [1, 4, 7, 0, 2, 5, 8, 3, 9],
        [0, 1, 9, 2, 8, 3, 4, 7, 5],
      ];
      expect(solver.getField(), intField);
    });
    test("grid with one Null Line", () {
      List<String> rawInput = [
        "123456789",
        "987654321",
        "",
        "147025839",
        "123456789",
        "987654321",
        "135792468",
        "147025839",
        "019283475",
      ];
      final solver = Solver(rawInput);

      List<List<int?>> intField = [
        [1, 2, 3, 4, 5, 6, 7, 8, 9],
        [9, 8, 7, 6, 5, 4, 3, 2, 1],
        [null, null, null, null, null, null, null, null, null],
        [1, 4, 7, 0, 2, 5, 8, 3, 9],
        [1, 2, 3, 4, 5, 6, 7, 8, 9],
        [9, 8, 7, 6, 5, 4, 3, 2, 1],
        [1, 3, 5, 7, 9, 2, 4, 6, 8],
        [1, 4, 7, 0, 2, 5, 8, 3, 9],
        [0, 1, 9, 2, 8, 3, 4, 7, 5],
      ];
      expect(solver.getField(), intField);
    });

    test("grid with Spaces and .", () {
      List<String> rawInput = [
        "12 45 789",
        "98.654.21",
        "",
        "147025839",
        "",
        "987654321",
        "135792468",
        "147025839",
        "019283475",
      ];
      final solver = Solver(rawInput);

      List<List<int?>> intField = [
        [1, 2, null, 4, 5, null, 7, 8, 9],
        [9, 8, null, 6, 5, 4, null, 2, 1],
        [null, null, null, null, null, null, null, null, null],
        [1, 4, 7, 0, 2, 5, 8, 3, 9],
        [null, null, null, null, null, null, null, null, null],
        [9, 8, 7, 6, 5, 4, 3, 2, 1],
        [1, 3, 5, 7, 9, 2, 4, 6, 8],
        [1, 4, 7, 0, 2, 5, 8, 3, 9],
        [0, 1, 9, 2, 8, 3, 4, 7, 5],
      ];
      expect(solver.getField(), intField);
    });
  });
}