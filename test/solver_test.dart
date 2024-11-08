// Import the test package and Counter class

import 'package:sudoku_solver/data/repositories/solver.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    //fully solved sudoku to copy from
    /*List<String> firstSudokuInput = [
      "613458297",
      "872319564",
      "945267381",
      "239146758",
      "754982613",
      "186573429",
      "397621845",
      "468795132",
      "521834976",
    ];
    Solver firstSudokuSolver = Solver(firstSudokuInput);
    List<List<List<int?>>> fullOptionField = [
      [[6], [1], [3], [4], [5], [8], [2], [9], [7]],
      [[8], [7], [2], [3], [1], [9], [5], [6], [4]],
      [[9], [4], [5], [2], [6], [7], [3], [8], [1]],
      [[2], [3], [9], [1], [4], [6], [7], [5], [8]],
      [[7], [5], [4], [9], [8], [2], [6], [1], [3]],
      [[1], [8], [6], [5], [7], [3], [4], [2], [9]],
      [[3], [9], [7], [6], [2], [1], [8], [4], [5]],
      [[4], [6], [8], [7], [9], [5], [1], [3], [2]],
      [[5], [2], [1], [8], [3], [4], [9], [7], [6]],
    ];
    List<List<List<int?>>> emptyField = [
      [[], [], [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], [], []],
      [[], [], [], [], [], [], [], [], []],
    ];
    */
  });
    group("Calculate Options", ()
    {
      //Use first solved sudoku with empty numbers on the left side. Calculate
      //only bases one possibilities in one line
      test("left side only lines", () {
        //Arrange
        List<String> leftInput = [
          "603458297",
          "000319564",
          "040267381",
          "230146758",
          "054982613",
          "006573429",
          "300621845",
          "008795132",
          "500834976",
        ];
        Solver leftSolver = Solver(leftInput);
        List<List<List<int?>>> leftOptionField = [
          [[6], [1], [3], [4], [5], [8], [2], [9], [7]],
          [[2,7,8], [2,7,8], [2,7,8], [3], [1], [9], [5], [6], [4]],
          [[5,9], [4], [5,9], [2], [6], [7], [3], [8], [1]],
          [[2], [3], [9], [1], [4], [6], [7], [5], [8]],
          [[7], [5], [4], [9], [8], [2], [6], [1], [3]],
          [[1,8], [1,8], [6], [5], [7], [3], [4], [2], [9]],
          [[3], [7,9], [7,9], [6], [2], [1], [8], [4], [5]],
          [[4,6], [4,6], [8], [7], [9], [5], [1], [3], [2]],
          [[5], [1,2], [1,2], [8], [3], [4], [9], [7], [6]],
        ];
        //Act
        leftSolver.copyStartGridToOptions();
        leftSolver.calculateLine();
        //Assert
        expect(leftSolver.getOptions(), leftOptionField);
      });
    });

    //Use first solved sudoku with empty numbers on the left side. Calculate
    //only bases one possibilities in one line
    test("lines only", () {
      //Arrange
      List<String> firstSudoku = [
        "405678000",
        "978321456",
        "601095703",
        "200086900",
        "896714035",
        "007032640",
        "504203007",
        "309847010",
        "000050300",
      ];
      Solver firstRealSolver = Solver(firstSudoku);
      List<List<List<int?>>> firstSudokuOptions = [
        [[4], [1, 2, 3, 9], [5], [6], [7], [8], [1, 2, 3, 9], [1, 2, 3, 9], [1, 2, 3, 9]],
        [[9], [7], [8], [3], [2], [1], [4], [5], [6]],
        [[6], [2, 4,8], [1], [2, 4, 8], [9], [5], [7], [2, 4, 8], [3]],
        [[2], [1, 3, 4, 5, 7], [1, 3, 4, 5, 7],  [1, 3, 4, 5, 7], [8], [6], [9],[ 1, 3, 4, 5, 7], [1, 3, 4, 5, 7]],
        [[8], [9], [6], [7], [1], [4], [2], [3], [5]],
        [[1, 5, 8, 9], [1, 5, 8, 9], [7], [1, 5, 8, 9 ], [3], [2], [6], [4], [1, 5, 8, 9]],
        [[5], [1, 6, 8, 9], [4], [2], [1, 6, 8, 9], [3], [1, 6, 8, 9], [1, 6, 8, 9], [7]],
        [[3], [2, 5, 6], [9], [8], [4], [7], [2, 5, 6], [1], [2, 5, 6]],
        [[1, 2, 4, 6, 7, 8, 9], [1, 2, 4, 6, 7, 8, 9], [1, 2, 4, 6, 7, 8, 9], [1, 2, 4, 6, 7, 8, 9], [5], [1, 2, 4, 6, 7, 8, 9], [3], [1, 2, 4, 6, 7, 8, 9], [1, 2, 4, 6, 7, 8, 9],]
      ];
      //Act
      firstRealSolver.copyStartGridToOptions();
      firstRealSolver.calculateLine();
      //Assert
      expect(firstRealSolver.getOptions(), firstSudokuOptions);
    });

    test("lines and horizontal", () {
      //Arrange
      List<String> firstSudoku = [
        "405678000",
        "978321456",
        "601095703",
        "200086900",
        "896714035",
        "007032640",
        "504203007",
        "309847010",
        "000050300",
      ];
      Solver firstRealSolver = Solver(firstSudoku);
      List<List<List<int?>>> firstSudokuOptions = [
        [[4],                   [1, 2, 3],             [5],              [6],             [7],           [8],                   [1, 2],                   [2, 9],                [1, 2, 9]],
        [[9],                   [7],                   [8],              [3],             [2],           [1],                   [4],                      [5],                   [6]],
        [[6],                   [2, 4,8],              [1],              [4],             [9],           [5],                   [7],                      [2, 8],                [3]],
        [[2],                   [1, 3, 4, 5],          [3],              [1, 4, 5],       [8],           [6],                   [9],                      [7],                   [1, 4]],
        [[8],                   [9],                   [6],              [7],             [1],           [4],                   [2],                      [3],                   [5]],
        [[1],                   [1, 5, 8],             [7],              [1, 5, 9 ],      [3],           [2],                   [6],                      [4],                   [1, 8, 9]],
        [[5],                   [1, 6, 8],             [4],              [2],             [6],           [3],                   [1, 8],                   [6, 8, 9],             [7]],
        [[3],                   [2, 5, 6],             [9],              [8],             [4],           [7],                   [2, 5],                   [1],                   [2]],
        [[1,7],                 [1, 2, 4, 6, 8],       [2],              [1, 4, 9],       [5],           [9],                   [3],                      [2, 6, 7, 8, 9],       [1, 2, 4, 8, 9],]
      ];
      //Act
      firstRealSolver.copyStartGridToOptions();
      firstRealSolver.calculateLine();
      firstRealSolver.calculateColumn();
      //Assert
      expect(firstRealSolver.getOptions(), firstSudokuOptions);
    });
    test("lines horzontal quare test until end", (){
      //Arrange
      List<String> firstSudoku = [
        "405678000",
        "978321456",
        "601095703",
        "200086900",
        "896714035",
        "007032640",
        "504203007",
        "309847010",
        "000050300",
      ];
      Solver loopSolver = Solver(firstSudoku);
      List<List<List<int?>>> allOnceOptions = [
        [[4],                   [3],                   [5],              [6],             [7],           [8],                   [1],                      [9],                   [9]],
        [[9],                   [7],                   [8],              [3],             [2],           [1],                   [4],                      [5],                   [6]],
        [[6],                   [2],                   [1],              [4],             [9],           [5],                   [7],                      [8],                   [3]],
        [[2],                   [4],                   [3],              [5],             [8],           [6],                   [9],                      [7],                   [1]],
        [[8],                   [9],                   [6],              [7],             [1],           [4],                   [2],                      [3],                   [5]],
        [[1],                   [5],                   [7],              [9],             [3],           [2],                   [6],                      [4],                   [8]],
        [[5],                   [1],                   [4],              [2],             [6],           [3],                   [8],                      [9],                   [7]],
        [[3],                   [6],                   [9],              [8],             [4],           [7],                   [5],                      [1],                   [2]],
        [[7],                   [8],                   [2],              [1],             [5],           [9],                   [3],                      [6],                   [4]]
      ];
      //Act
      loopSolver.copyStartGridToOptions();
      loopSolver.calculateAllOptionens();
      //Assert
      expect(loopSolver.getOptions(), allOnceOptions);
    });
    test("lines horzontal quare test once", (){
      //Arrange
      List<String> firstSudoku = [
        "405678000",
        "978321456",
        "601095703",
        "200086900",
        "896714035",
        "007032640",
        "504203007",
        "309847010",
        "000050300",
      ];
      Solver onceSolver = Solver(firstSudoku);
      List<List<List<int?>>> allOnceOptions = [
        [[4],                   [2, 3],                [5],              [6],             [7],           [8],                   [1, 2],                   [2, 9],                [1, 2, 9]],
        [[9],                   [7],                   [8],              [3],             [2],           [1],                   [4],                      [5],                   [6]],
        [[6],                   [2],                   [1],              [4],             [9],           [5],                   [7],                      [2, 8],                [3]],
        [[2],                   [4, 5],                [3],              [5],             [8],           [6],                   [9],                      [7],                   [1]],
        [[8],                   [9],                   [6],              [7],             [1],           [4],                   [2],                      [3],                   [5]],
        [[1],                   [5],                   [7],              [5, 9],          [3],           [2],                   [6],                      [4],                   [1, 8]],
        [[5],                   [1, 6, 8],             [4],              [2],             [6],           [3],                   [8],                      [6, 8, 9],             [7]],
        [[3],                   [6],                   [9],              [8],             [4],           [7],                   [5],                      [1],                   [2]],
        [[1,7],                 [1, 6, 8],             [2],              [1],             [5],           [9],                   [3],                      [ 6, 8, 9],            [4, 8, 9],]
      ];
      //Act
      onceSolver.copyStartGridToOptions();
      onceSolver.calculateLine();
      onceSolver.calculateColumn();
      onceSolver.calculateSquare();
      //Assert
      expect(onceSolver.getOptions(), allOnceOptions);
    });
}

