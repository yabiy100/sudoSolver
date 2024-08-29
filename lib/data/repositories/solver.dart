class Solver {
  List<List<int?>> grid = [];
  int lineSize = 9;
  List<List<int?>> solvedGrid = [];

  Solver(List<String> rawInput){
    transform(rawInput);
    solvedGrid = grid;
    printGrid();
    solveGrid();
  }

  void transform(List<String> rawInput) {
    print(rawInput);
    for(String line in rawInput){
      List<int?> intLine = [];
      if(line.isEmpty){
        intLine = List.filled(9, null);
        grid.add(intLine);
      }else {
        //Analyze each Character of each Line
        transformEachNumber(line, intLine);
      }
    }
  }

  void transformEachNumber(String line, List<int?> intLine) {
    for(int i = 0; i < lineSize; i++){
      if(line[i] == " " || line[i] == "."){
        intLine.add(null);
      }else{
        intLine.add(int.parse(line[i]));
      }
    }
    grid.add(intLine);
  }
  void solveGrid(){
    List<List<List<int?>>> options = [];
    copyStartGrid(options);
    //find out which Number isnt used in a line and save them
    //in every empty field
    for(List<List<int?>> line in options){
      List<int?> allNumbers = [0,1,2,3,4,5,6,7,8,9];
      calculateOptionsInLine(allNumbers);
      for(List<int?> field in line){
        if(field == null){
          field.addAll(allNumbers);
        }
      }
    }
    //print(options);


  }

  void calculateOptionsInLine(List<dynamic> allNumbers) {
    for(List<int?> field in solvedGrid){
      int? number = field.firstOrNull;
      if(number != null){
        allNumbers.remove(number);
      }
    }
  }

  void copyStartGrid(List<List<List<int?>>> options) {
     List<List<int?>> line = [];
    for(List<int?> number in solvedGrid){
      if(number.first != null){
        line.add(number);
      }else{
        line.add(List.filled(9, null));
      }
    }
    options.add(line);
    //print("solved: $options" );
  }

  void printGrid(){
    for(List<int?> line in grid){
      print(line);
    }
  }

}