import 'package:flutter/material.dart';
import 'package:question_answer_app/question_engine.dart';

QuestionEngine questionEngine = QuestionEngine();

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Widget> recordTracker = [];
  bool showExplanation = false;
  bool answered = false;
  int? selectedAnswerIndex;

  Future<void> _showCompleteDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Quiz Complete!'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Final Score: ${questionEngine.totalScore}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E88E5),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Correct Answers: ${questionEngine.correctAnswers}/${questionEngine.getQuestionsCount()}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                'Think you can do better? Try again!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
                questionEngine.reset();
                recordTracker = [];
                showExplanation = false;
                answered = false;
                selectedAnswerIndex = null;
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF1E88E5),
              foregroundColor: Colors.white,
            ),
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void checkAnswer(String userSelectedAnswer, int weightValue, int index) {
    if (answered) return; // Prevent multiple answers

    String correctAnswer = questionEngine.getCorrectAnswer();
    bool isCorrect = userSelectedAnswer == correctAnswer;

    setState(() {
      answered = true;
      selectedAnswerIndex = index;
      showExplanation = true;

      if (isCorrect) {
        questionEngine.correctAnswers++;
        recordTracker.add(
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 24,
          ),
        );
      } else {
        recordTracker.add(
          const Icon(
            Icons.cancel,
            color: Colors.red,
            size: 24,
          ),
        );
      }

      questionEngine.totalScore += weightValue > 0 ? weightValue : 0;
    });
  }

  void nextQuestion() {
    setState(() {
      if (questionEngine.didFinishQuiz()) {
        _showCompleteDialog();
      } else {
        questionEngine.nextQuestion();
        answered = false;
        showExplanation = false;
        selectedAnswerIndex = null;
      }
    });
  }

  Color getButtonColor(int index) {
    if (!answered) {
      return const Color(0xFF1E88E5);
    }

    String correctAnswer = questionEngine.getCorrectAnswer();
    String answer = questionEngine.getAnswers()[index];

    if (answer == correctAnswer) {
      return Colors.green;
    } else if (selectedAnswerIndex == index) {
      return Colors.red;
    } else {
      return const Color(0xFF64B5F6); // Light blue for non-selected answers
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Progress indicator
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${questionEngine.getCurrentQuestionNumber()}/${questionEngine.getQuestionsCount()}',
                style: const TextStyle(
                  color: Color(0xFF1E88E5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Row(
              //   children: [
              //     const Icon(Icons.emoji_events, color: Color(0xFFFFD700)),
              //     const SizedBox(width: 4),
              //     Text(
              //       '${questionEngine.totalScore}',
              //       style: const TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 16,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),

        LinearProgressIndicator(
          value: questionEngine.getCurrentQuestionNumber() /
              questionEngine.getQuestionsCount(),
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
        ),

        const SizedBox(height: 16),

        // Question
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                questionEngine.getQuestionTextForCurrentQuestion(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E88E5),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Answer choices
        Expanded(
          flex: 5,
          child: ListView.builder(
            itemCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: MaterialButton(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: answered
                      ? null
                      : () {
                          checkAnswer(
                            questionEngine.getAnswers()[index],
                            questionEngine.getScoreFromAnswers()[index],
                            index,
                          );
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: getButtonColor(index),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + index), // A, B, C, D
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            questionEngine.getAnswers()[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (answered &&
                            questionEngine.getAnswers()[index] ==
                                questionEngine.getCorrectAnswer())
                          const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Next button & score display
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Score and tracker icons
              Expanded(
                child: Row(
                  children: [
                    const Text(
                      'Score: ',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${questionEngine.totalScore}',
                      style: const TextStyle(
                        color: Color(0xFF1E88E5),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: recordTracker),
                      ),
                    ),
                  ],
                ),
              ),

              // Next button
              if (answered)
                ElevatedButton(
                  onPressed: nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(questionEngine.didFinishQuiz() ? 'Finish' : 'Next'),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
