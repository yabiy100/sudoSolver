import 'package:flutter/material.dart';
import 'package:sudoku_solver/data/repositories/solver.dart';
import 'package:sudoku_solver/screens/input_screen.dart';
import 'package:sudoku_solver/screens/solution_screen.dart';
import 'package:sudoku_solver/screens/titel_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Solver testSolver = Solver([
      "003009267",
      "090860000",
      "201500400",
      "900401080",
      "076000130",
      "010607009",
      "009005603",
      "000094010",
      "835700900",
    ]);
    return MaterialApp(
      title: 'Sudoku Solver',
      /*inixtialRoute: "/",
      routes: {
        "/": (context) => const TitleScreen(),
        "/input": (context) => const InputScreen(),
      },*/
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: SolutionScreen(sudoku: testSolver),
    );
  }
}
