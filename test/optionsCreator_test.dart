// Import the test package and Counter class
//@formatter:off
import 'package:sudoku_solver/data/repositories/optionsCreator.dart';
import 'package:test/test.dart';

void main() {
  group("Raw Input to  optione", () {
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
      //@formatter:off
      List<List<List<int>>> emptyField = [
        [[0],[0],[0],[0],[0],[0],[0],[0],[0]],
        [[0],[0],[0],[0],[0],[0],[0],[0],[0]],
        [[0],[0],[0],[0],[0],[0],[0],[0],[0]],
        [[0],[0],[0],[0],[0],[0],[0],[0],[0]],
        [[0],[0],[0],[0],[0],[0],[0],[0],[0]],
        [[0],[0],[0],[0],[0],[0],[0],[0],[0]],
        [[0],[0],[0],[0],[0],[0],[0],[0],[0]],
        [[0],[0],[0],[0],[0],[0],[0],[0],[0]],
        [[0],[0],[0],[0],[0],[0],[0],[0],[0]],
      ];
      //@formatter:on
      optionsCreator options = optionsCreator(emptyGrid);
      //Accept
      expect(options.getOptions(), emptyField);
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
      //@formatter:off
      List<List<List<int>>> fullField = [
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


      optionsCreator OptionesCreaterFull = optionsCreator(fullInput);
      expect(OptionesCreaterFull.getOptions(), fullField);
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
      optionsCreator oneLineEmptyOptionesCreater = optionsCreator(oneLineEmptyInput);
      //@formatter:off
      List<List<List<int>>> intField = [
        [[1], [2], [3], [4], [5], [6], [7], [8], [9]],
        [[9], [8], [7], [6], [5], [4], [3], [2], [1]],
        [[0], [0], [0], [0], [0], [0], [0], [0], [0]],
        [[1], [4], [7], [0], [2], [5], [8], [3], [9]],
        [[1], [2], [3], [4], [5], [6], [7], [8], [9]],
        [[9], [8], [7], [6], [5], [4], [3], [2], [1]],
        [[1], [3], [5], [7], [9], [2], [4], [6], [8]],
        [[1], [4], [7], [0], [2], [5], [8], [3], [9]],
        [[0], [1], [9], [2], [8], [3], [4], [7], [5]],
      ];
      //@formatter:on
      expect(oneLineEmptyOptionesCreater.getOptions(), intField);
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
      final OptionesCreater = optionsCreator(rawInput);
      //@formatter:off
      List<List<List<int>>> intField = [
        [[1], [2], [0], [4], [5], [0], [7], [8], [9]],
        [[9], [8], [0], [6], [5], [4], [0], [2], [1]],
        [[0], [0], [0], [0], [0], [0], [0], [0], [0]],
        [[1], [4], [7], [0], [2], [5], [8], [3], [9]],
        [[0], [0], [0], [0], [0], [0], [0], [0], [0]],
        [[9], [8], [7], [6], [5], [4], [3], [2], [1]],
        [[1], [3], [5], [7], [9], [2], [4], [6], [8]],
        [[1], [4], [7], [0], [2], [5], [8], [3], [9]],
        [[0], [1], [9], [2], [8], [3], [4], [7], [5]],
      ];
      //@formatter:on
      expect(OptionesCreater.getOptions(), intField);
    });
  });
}

