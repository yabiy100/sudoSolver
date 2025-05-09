import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:sudoku_solver/data/repositories/solver.dart";
import "package:sudoku_solver/screens/solution_screen.dart";
import "../data/repositories/sudokuGenerator.dart";
import "error_screen.dart";

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();

  RegExp regExp = RegExp('[0-9]');
  List<String> fields = List.filled(81, "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter in Sudoku"),
        backgroundColor: const Color(0xffE29A4C),
      ),
      body: SafeArea(
        child: Container(
        color: Colors.blue,
          child: Column(
            children: [
              OverflowBar(
                alignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SudokuButton(
                      index: "${index + 1}",
                      onPressed: () {
                        SudokuGenerator generator = new SudokuGenerator();
                        final sudoku = generator.getSudoku(index);
                        setState(() {
                          //konvert List of 9 line to one String Symbol each
                          fields = sudoku.expand((line) => line.split("")).toList();
                        });
                      },
                    ),
                  );
                }),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1, //Sqaure grid 1:1
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 9,
                          childAspectRatio: 1,
                        ),
                        itemCount: 81,
                        itemBuilder: (context, index) {
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
                            child: inputField(index),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      print('Form is valid. Lines: $fields');
                      // transform List of Strings to lines to fit existing format
                      List<String> lines = List.generate(9, (i) {
                        return fields.sublist(i*9, (i+1) * 9).join("");
                      });
                      Solver solver = Solver(lines);
                      solver.solveSudoku();
                      if(solver.getGrid() == null){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ErrorScreen(),
                          ),
                        );
                      }
                      // Ensure Solver is correctly defined
                      if(solver.getGrid() != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SolutionScreen(sudoku: solver),
                          ),
                        );
                      }
                    } else {
                      print('Form is not valid.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffE29A4C),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text("Calculate Solution"),
                ),
              ],
            ),
        ),
      ),
    );
  }



  TextFormField inputField(int index) {
    return TextFormField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(          border: InputBorder.none,  // Removes the underline (focus border)
          contentPadding: EdgeInsets.zero, // Removes internal padding
        ),
        //if field is empty (0) show notging. Else Show number from sudoku
        controller: TextEditingController(text: fields[index] == "0" ? "" : fields[index]),
        validator: (value) {
        if(value == null || value.isEmpty){
          return null;
        }
        if(!regExp.hasMatch(value)){
          return "Please only enter in Numbers";
        }
        if(value.length != 1){
          return "Please only Enter in one Number per Field";
        }
        return null;
      },
        onSaved: (value) {
          //empty field is represented by empty String
          if(value == "" || value == null){
            fields[index] = "0";
          }else{
            fields[index]=  value;
          }
          print(fields[index]);
        }
    );
  }
}

class SudokuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String index;

  const SudokuButton({
    super.key,
    required this.onPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
        backgroundColor: Color(0xffE29A4C),
        ),
      onPressed: onPressed,
      child: Text(
        "Sudoku " +  index,
        style: const TextStyle(color: Colors.black, fontSize: 36),
      ),
    );
  }
}

