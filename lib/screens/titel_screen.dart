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
            // Padding überall:
            // padding: const EdgeInsets.all(64),
            // Padding unterschiedlich horizontal und vertikal:
            // padding: const EdgeInsets.symmetric(
            //   vertical: 24,
            //   horizontal: 96,
            // ),
            // Padding einzeln definiert:
            // padding: const EdgeInsets.only(
            //   bottom: 8,
            //   top: 32,
            //   right: 24,
            //   left: 16,
            // ),
            // Padding einzeln definiert Variante (left, top, right, bottom):
            padding: const EdgeInsets.fromLTRB(16, 32, 24, 8),
            child: Image.asset("assets/images/sudoku.png"),
          ),
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }
}
