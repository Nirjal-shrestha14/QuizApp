import 'package:flutter/material.dart';
import 'package:question_answer_app/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'La Liga Quiz',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1E88E5), // Sky blue
            primary: const Color(0xFF1E88E5),
            secondary: const Color(0xFF64B5F6),
            background: const Color(0xFFE3F2FD),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1E88E5),
            foregroundColor: Colors.white,
          ),
          useMaterial3: true,
        ),
        home: Scaffold(
          backgroundColor: const Color(0xFFE3F2FD),
          appBar: AppBar(
            title: const Text(
              'LA LIGA QUIZ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            centerTitle: true,
          ),
          body: const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: QuizScreen(),
            ),
          ),
        ));
  }
}
