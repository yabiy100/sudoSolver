// Import the test package and Counter class

import 'package:sudoku_solver/data/repositories/solver.dart';
import 'package:test/test.dart';

void main() {
  group("Raw Input to Field", ()
  {
    test("Everything Empty", () {
      //Arrange
      List<String> emptyGrid = [
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
      ];
      List<List<int>> emptyField = [
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],

      ];
      Solver solverEmpty = Solver(emptyGrid);
      //Accept
      expect(solverEmpty.getField(), emptyField);
    });
    test("grid with just numbers", () {
      List<String> fullInput = [
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
      List<List<int>> fullField = [
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

      Solver solverFull = Solver(fullInput);
      expect(solverFull.getField(), fullField);
    });
    test("grid with one Null Line", () {
      List<String> oneLineEmptyInput = [
        "123456789",
        "987654321",
        "000000000",
        "147025839",
        "123456789",
        "987654321",
        "135792468",
        "147025839",
        "019283475",
      ];
      Solver oneLineEmptySolver = Solver(oneLineEmptyInput);
      List<List<int>> intField = [
        [1, 2, 3, 4, 5, 6, 7, 8, 9],
        [9, 8, 7, 6, 5, 4, 3, 2, 1],
        [0,0,0,0,0,0,0,0,0],
        [1, 4, 7, 0, 2, 5, 8, 3, 9],
        [1, 2, 3, 4, 5, 6, 7, 8, 9],
        [9, 8, 7, 6, 5, 4, 3, 2, 1],
        [1, 3, 5, 7, 9, 2, 4, 6, 8],
        [1, 4, 7, 0, 2, 5, 8, 3, 9],
        [0, 1, 9, 2, 8, 3, 4, 7, 5],
      ];
      expect(oneLineEmptySolver.getField(), intField);
    });

    test("grid with Spaces and .", () {
      List<String> rawInput = [
        "120450789",
        "980654021",
        "000000000",
        "147025839",
        "000000000",
        "987654321",
        "135792468",
        "147025839",
        "019283475",
      ];
      final solver = Solver(rawInput);

      List<List<int>> intField = [
        [1, 2, 0, 4, 5, 0, 7, 8, 9],
        [9, 8, 0, 6, 5, 4, 0, 2, 1],
        [0,0,0,0,0,0,0,0,0],
        [1, 4, 7, 0, 2, 5, 8, 3, 9],
        [0,0,0,0,0,0,0,0,0],
        [9, 8, 7, 6, 5, 4, 3, 2, 1],
        [1, 3, 5, 7, 9, 2, 4, 6, 8],
        [1, 4, 7, 0, 2, 5, 8, 3, 9],
        [0, 1, 9, 2, 8, 3, 4, 7, 5],
      ];
      expect(solver.getField(), intField);
    });
  });
  group("Grid to Options", ()
  {
    test("All Numbers over to options", () {
      List<List<List<int>>> intOptionField = [
        [[1], [2], [3], [4], [5], [6], [7], [8], [9]],
        [[9], [8], [7], [6], [5], [4], [3], [2], [1]],
        [[1], [3], [5], [7], [9], [2], [4], [6], [8]],
        [[1], [4], [7], [0], [2], [5], [8], [3], [9]],
        [[1], [2], [3], [4], [5], [6], [7], [8], [9]],
        [[9], [8], [7], [6], [5], [4], [3], [2], [1]],
        [[1], [3], [5], [7], [9], [2], [4], [6], [8]],
        [[1], [4], [7], [0], [2], [5], [8], [3], [9]],
        [[0], [1], [9], [2], [8], [3], [4], [7], [5]],
      ];
      List<String> fullInput = [
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
      Solver fullInputSolver = Solver(fullInput);
      fullInputSolver.copyStartGridToOptions();
      expect(fullInputSolver.getOptions(), intOptionField);
    });
    test("Some empty", (){
      //Assert
      List<List<List<int>>> intOptionField = [
        [[1], [2], [3], [4], [5], [6], [7], [8], [9]],
        [[9], [0], [7], [6], [5], [4], [3], [0], [1]],
        [[1], [3], [5], [7], [9], [2], [4], [6], [8]],
        [[0], [0], [0], [0], [0], [0], [0], [0], [0]],
        [[1], [2], [3], [4], [5], [6], [7], [8], [9]],
        [[9], [0], [0], [0], [0], [0], [0], [0], [1]],
        [[1], [3], [5], [7], [9], [2], [4], [6], [8]],
        [[1], [0], [0], [0], [2], [0], [0], [3], [9]],
        [[0], [1], [9], [2], [8], [3], [4], [7], [5]],
      ];
      List<String> someLinesEmptyInput = [
        "123456789",
        "907654301",
        "135792468",
        "000000000",
        "123456789",
        "900000001",
        "135792468",
        "100020039",
        "019283475",
      ];
      Solver fullInputSolver = Solver(someLinesEmptyInput);
      //Act
      fullInputSolver.copyStartGridToOptions();
      //Accept
      expect(fullInputSolver.getOptions(), intOptionField);
    });
  });
}


