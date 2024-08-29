import "package:flutter/material.dart";
import "package:sudoku_solver/data/repositories/solver.dart";
import "package:sudoku_solver/widgets/custom_button.dart";

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();

  RegExp regExp = RegExp(r'^[0-9\s.]+$');
  List<String> lines = List.filled(9, "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter in Sudoku"),
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
                const Text(
                  """Please Enter each line of your sudoku and use spaces or . for 
                      empthy spots"""
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
                      // You can now work with the `lines` list which holds the input data
                      print('Form is valid. Lines: $lines');
                    } else {
                      print('Form is not valid.');
                    }
                    Solver Ysolver = new Solver(lines);
                  },
                  child: Text('Calculate Solution'),
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
