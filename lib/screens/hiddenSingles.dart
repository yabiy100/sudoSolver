import 'package:sudoku_solver/data/repositories/solvingTechniques.dart';

class hiddenSingles extends solvingTechniques{
  hiddenSingles(super.options);

  void singlesInLine(){
    //go through a line and count how often a number is present in all fields
    //combined. Search for a single
    for(int row = 0; row < lineSize; row++){
      List<int> counter = [0,0,0,0,0,0,0,0,0];
      for(int col = 0; col < lineSize; col++){
        List<int> field = options[row][col];
        if(field.length > 1){
          for(int number in field){
            counter[number]++;
          }
        }
      }
      //check if single is found
      for(int col = 0; col < lineSize; col++){
        if(counter[col] == 1) {
          for (int i = 0; i < lineSize; i++) {
            List<int> field = options[row][i];
            if (field.contains(col)) {
              options[row][i] = [col];
            }
          }
        }
      }
    }
  }
}