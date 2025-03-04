import "package:flutter/material.dart";
import "package:sudoku_solver/screens/solution_screen.dart";

import "../data/repositories/solver.dart";


class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();

  RegExp regExp = RegExp(r'^[0-9]+$');
  List<String> lines = List.filled(9, "");
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
              child: Container(
                color: const Color(0xffE29A4C), // color of form
                padding: const EdgeInsets.all(16), // padding around the form
                child: Column(
                  mainAxisSize: MainAxisSize.min, // minimize height
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Please enter each line of your Sudoku and use 0 for empty spots",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    for (int i = 0; i < 9; i++) inputName("${i + 1}.Line", i), // create 9 input fields
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  print('Form is valid. Lines: $lines');
                  Solver solver = Solver(lines); // Ensure Solver is correctly defined
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


}
