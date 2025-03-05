// Import the test package and Counter class

import 'package:sudoku_solver/data/repositories/optionsCreator.dart';
import 'package:sudoku_solver/data/repositories/solver.dart';
import 'package:test/test.dart';

void main() {
  //@formatter:off
  setUp(() {
    /*empty test
    test("lines horzontal quare until end", (){
      expect(leftSolver.getOptions(), leftOptionField);
    });
    */

  });
  test("dual 6 in Line", () {
    //Arrange
    List<String> sevenLineInput = [
      "603458297",
      "000319564",
      "040267381",
      "230146758",
      "054982613",
      "006573429",
      "300621845",
      "008795132",
      "500834966",
    ];
    optionsCreator nullOptions = optionsCreator(sevenLineInput);
    expect(nullOptions.checkForErrors(), "Error: 6 appears twice in Line 9");
  });
}
