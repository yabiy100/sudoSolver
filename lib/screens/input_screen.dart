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
        child: SingleChildScrollView(
          padding: MediaQuery.of(context).orientation == Orientation.portrait
              ? const EdgeInsets.all(24)
              : EdgeInsets.symmetric(
            vertical: 40,
            horizontal: MediaQuery.of(context).size.width / 5,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                LayoutBuilder(
                  builder: (context, constraints) {
                    double fontSize = constraints.maxWidth * 0.04; // Scales font size dynamically
                    return Container(
                      padding: const EdgeInsets.all(16),
                      color: const Color(0xffE29A4C), // Matches AppBar background color
                      child: Text(
                        "Please enter each line of your Sudoku and use 0 for empty spots",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize.clamp(14, 20), // Ensures font size stays between 14 and 20
                        ),
                      ),
                    );
                  },
                ),
                inputName("1.Line",0),
                inputName("2.Line",1),
                inputName("3.Line",2),
                inputName("4.Line",3),
                inputName("5.Line",4),
                inputName("6.Line",5),
                inputName("7.Line",6),
                inputName("8.Line",7),
                inputName("9.Line",8),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      print('Form is valid. Lines: $lines');
                    } else {
                      print('Form is not valid.');
                    }
                    Solver Ysolver = Solver(lines);
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
      backgroundColor: Colors.blue,
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
