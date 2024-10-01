// Import the test package and Counter class

import 'package:sudoku_solver/data/repositories/solver.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {
    //fully solved suddoku to copy from
    List<String> firstSudokuInput = [
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
    Solver firstSudoukuSolver = Solver(firstSudokuInput);
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
  });
  group("Raw Input to Field", ()
  {
    test("Everything Empty", () {
      //Arange
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
      List<List<int?>> emptyfield = [
        [null,null,null,null,null,null,null,null,null],
        [null,null,null,null,null,null,null,null,null],
        [null,null,null,null,null,null,null,null,null],
        [null,null,null,null,null,null,null,null,null],
        [null,null,null,null,null,null,null,null,null],
        [null,null,null,null,null,null,null,null,null],
        [null,null,null,null,null,null,null,null,null],
        [null,null,null,null,null,null,null,null,null],
        [null,null,null,null,null,null,null,null,null],
      ];
      Solver solverEmpty = Solver(emptyGrid);
      //Accept
      expect(solverEmpty.getField(), emptyfield);
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
      List<List<int?>> fullField = [
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
        "",
        "147025839",
        "123456789",
        "987654321",
        "135792468",
        "147025839",
        "019283475",
      ];
      Solver oneLineEmptySolver = Solver(oneLineEmptyInput);
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
      expect(oneLineEmptySolver.getField(), intField);
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

  group("Grid to Options", ()
  {
    test("All Numbers over to options", () {
      List<List<List<int?>>> intOptionField = [
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
      List<List<List<int?>>> intOptionField = [
        [[1], [2], [3], [4], [5], [6], [7], [8], [9]],
        [[9], [null], [7], [6], [5], [4], [3], [null], [1]],
        [[1], [3], [5], [7], [9], [2], [4], [6], [8]],
        [[null], [null], [null], [null], [null], [null], [null], [null], [null]],
        [[1], [2], [3], [4], [5], [6], [7], [8], [9]],
        [[9], [null], [null], [null], [null], [null], [null], [null], [1]],
        [[1], [3], [5], [7], [9], [2], [4], [6], [8]],
        [[1], [null], [null], [0], [2], [null], [null], [3], [9]],
        [[0], [1], [9], [2], [8], [3], [4], [7], [5]],
      ];
      List<String> somelinesEmptyInput = [
        "123456789",
        "9.76543 1",
        "135792468",
        "",
        "123456789",
        "9 . . . 1",
        "135792468",
        "1  02..39",
        "019283475",
      ];
      Solver fullInputSolver = Solver(somelinesEmptyInput);
      //Act
      fullInputSolver.copyStartGridToOptions();
      //Accept
      expect(fullInputSolver.getOptions(), intOptionField);
    });
    group("Calculate Options", ()
    {
      //Use first solved sudoku with empty numbers on the left side. Calculate
      //only bases one possiblyties in one line
      test("left side only horzontal", () {
        //Arange
        List<String> leftInput = [
          "6 3458297",
          "   319564",
          " 4 267381",
          "23 146758",
          " 54982613",
          "  6573429",
          "3  621845",
          "  8795132",
          "5  834976",
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
        leftSolver.analyzeLine();
        //Assert
        expect(leftSolver.getOptions(), leftOptionField);
      });
    });

    //Use first solved sudoku with empty numbers on the left side. Calculate
    //only bases one possiblyties in one line
    test("left side orizontal and vertical", () {
      //Arange
      List<String> leftInput = [
        "6 3458297",
        "   319564",
        " 4 267381",
        "23 146758",
        " 54982613",
        "  6573429",
        "3  621845",
        "  8795132",
        "5  834976",
      ];
      Solver leftSolver = Solver(leftInput);
      List<List<List<int?>>> leftOptionField = [
        [[6], [1], [3], [4], [5], [8], [2], [9], [7]],
        [[7,8], [2,7,8], [2,7], [3], [1], [9], [5], [6], [4]],
        [[9], [4], [5,9], [2], [6], [7], [3], [8], [1]],
        [[2], [3], [9], [1], [4], [6], [7], [5], [8]],
        [[7], [5], [4], [9], [8], [2], [6], [1], [3]],
        [[1,8], [1,8], [6], [5], [7], [3], [4], [2], [9]],
        [[3], [7,9], [7,9], [6], [2], [1], [8], [4], [5]],
        [[4], [6], [8], [7], [9], [5], [1], [3], [2]],
        [[5], [1,2], [1,2], [8], [3], [4], [9], [7], [6]],
      ];
      //Act
      leftSolver.copyStartGridToOptions();
      leftSolver.calculateAllOptionens();
      //Assert
      expect(leftSolver.getOptions(), leftOptionField);
    });
    /*test("empty grid all numbers", () {

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
      Solver solverEmpty = Solver(emptyGrid);

      List<List<List<int?>>> allpossible = [
        [//first Row
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
        ],
        [
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
        ],
        [
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
        ],
        [
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
        ],
        [
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
        ],
        [
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
        ],
        [
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
        ],
        [
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
        ],
        [// last and 9. Line
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
          [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9], [1,2,3,4,5,6,7,8,9],
        ],
      ];
      expect(solverEmpty.getOptions(), allpossible);
    });*/
  });
}

