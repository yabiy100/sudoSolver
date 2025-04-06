import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sudoku not Solvable"),
        backgroundColor: const Color(0xffE29A4C),
      ),
      body:
      Container(
        color: Colors.blue,
        child: ListView(
          children: <Widget> [
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Couldn't solve Sudoku",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      "Please Check your Input",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 1, 24, 8),
                        child: Image.asset("assets/images/puppyError.png"),
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ]
        ),
      )
    );
  }
}