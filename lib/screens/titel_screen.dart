import "dart:async";
import "package:flutter/material.dart";

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, "/input");
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 24, 8),
            child: Image.asset("assets/images/sudoku.png"),
          ),
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }
}
