import "package:flutter/material.dart";
import "package:sudoku_solver/data/repositories/solver.dart";

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
          color: Colors.blue, // Background color for the entire SafeArea
          child: SingleChildScrollView(
            padding: MediaQuery.of(context).orientation == Orientation.portrait
                ? const EdgeInsets.all(24)
                : EdgeInsets.symmetric(
              vertical: 40,
              horizontal: MediaQuery.of(context).size.width / 5,
            ),
            child: Column(
            children: [
              Form(
              key: _formKey,
              child: Container(
                color: const Color(0xffE29A4C), // Brown canvas for Sudoku content
                padding: const EdgeInsets.all(16), // Adds padding around the content
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Adjusts height dynamically
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Please enter each line of your Sudoku and use 0 for empty spots",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16, // Can be adjusted or made dynamic
                        ),
                      ),
                    ),
                    for (int i = 0; i < 9; i++) inputName("${i + 1}.Line", i),
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
                } else {
                  print('Form is not valid.');
                }
                Solver Ysolver = Solver(lines); // Ensure Solver is correctly defined
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffE29A4C),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Calculate Solution'),
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
        filled: true, // Enables the background color
        fillColor: const Color(0xffE29A4C), // Sets the background color to blue
      ),
      validator: (value) {
        if(value == null || value.isEmpty){
          return null;
        }
        if(!regExp.hasMatch(value)){
          return "Please only enter Numbers or Spaces";
        }
        if(value.length != 9){
          return "Please enter 9 digits";
        }
        return null;
      },
        onSaved: (value) {
          // Save the value to the correct index in the lines list
          lines[index] = value ?? "";
        }
    );
}


}
