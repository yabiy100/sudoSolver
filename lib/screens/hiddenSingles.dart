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
            counter[number-1]++;
          }
        }
      }
      //check if single is found
      for(int col = 0; col < lineSize; col++){
        if(counter[col] == 1) {
          //go throw line to find position of number that is present once
          for(int index = 0; index < lineSize; index++){
            List<int> field = options[row][index];
            if(field.contains(col+1)) {
              options[row][index] = [col + 1];
            }
          }
        }
      }
    }
  }

  void singlesInRow(){
    for(int col = 0; col < lineSize; col++){
      List<int> counter = [0,0,0,0,0,0,0,0,0];
      for(int row = 0; row < lineSize; row++){
        List<int> field = options[row][col];
        if(field.length > 1){
          for(int number in field){
            counter[number-1]++;
          }
        }
      }
      //check if single is found
      for(int row = 0; row < lineSize; row++){
        if(counter[row] == 1) {
          for(int index = 0; index < lineSize; index++){
            List<int> field = options[index][col];
            if(field.contains(row+1)) {
              options[index][col] = [row + 1];
            }
          }
        }
      }
    }
  }
}