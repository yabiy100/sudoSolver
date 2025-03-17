import "package:flutter/material.dart";
import "package:sudoku_solver/screens/solution_screen.dart";

import "../data/repositories/solver.dart";


class NewInputScreen extends StatefulWidget {
  const NewInputScreen({super.key});

  @override
  State<NewInputScreen> createState() => _InputScreenState();
}


class _InputScreenState extends State<NewInputScreen> {
  final _formKey = GlobalKey<FormState>();

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
          child: SingleChildScrollView(
            padding: MediaQuery.of(context).orientation == Orientation.portrait
                ? const EdgeInsets.all(24) // when in Portrait mode
                : EdgeInsets.symmetric( // when in Landscape mode
              vertical: 40,
              horizontal: MediaQuery.of(context).size.width / 5,
            ),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 9,
                      childAspectRatio: 1,
                    ),
                    itemCount: 81,
                    itemBuilder: (context, index) {
                      //int? field = flatSudoku?[index];
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
                        child: Text(
                          field.toString(),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      /*
                      print('Form is valid. Lines: $lines');
                      Solver solver = Solver(lines); // Ensure Solver is correctly defined
                     */
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SolutionScreen(sudoku: solver),
                        ),
                      );
                    } else {
                      print('Form is not valid.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffE29A4C),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text("Calculate Solution"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


/* not needed for now
  TextFormField inputName(String label, int index) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: label,
          filled: true, // activates background
          fillColor: const Color(0xffE29A4C),
        ),
        validator: (value) {
          if(value == null || value.isEmpty){
            return "Please enter in the line";
          }
          if(!regExp.hasMatch(value)){
            return "Please only enter in Numbers";
          }
          if(value.length != 9){
            return "Please enter 9 digits";
          }
          //convert String to set to see if each character is there only once
          if(value.length != value.split('').toSet().length){
            return "Please enter each Number only once";
          }
          return null;
        },
        onSaved: (value) {
          lines[index] = value ?? ""; // if value is null safe empty string ""
        }
    );
  }
*/


}

