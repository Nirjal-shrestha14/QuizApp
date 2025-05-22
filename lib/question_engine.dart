import 'question.dart';

class QuestionEngine {
  int _questionNumber = 0;
  int correctAnswers = 0;
  int totalScore = 0;

  final List<Question> _questionList = [
    Question(
      'Which club has won the most La Liga titles?',
      ['Barcelona', 'Real Madrid', 'Atletico Madrid', 'Valencia'],
      'Real Madrid',
      [-1, 10, -1, -1],
    ),
    Question(
      'Who is the all-time top scorer in La Liga history?',
      ['Cristiano Ronaldo', 'Lionel Messi', 'Luis Suarez', 'Karim Benzema'],
      'Lionel Messi',
      [-1, 10, -1, -1],
    ),
    Question(
      'Which Spanish city is home to both Sevilla FC and Real Betis?',
      ['Madrid', 'Barcelona', 'Seville', 'Valencia'],
      'Seville',
      [-1, -1, 10, -1],
    ),
    Question(
      'Which player was nicknamed "El Pichichi"?',
      [
        'Rafael Moreno Aranzadi',
        'Francisco Gento',
        'Luis Suárez',
        'Alfredo Di Stéfano'
      ],
      'Rafael Moreno Aranzadi',
      [10, -1, -1, -1],
    ),
    Question(
      'Which team won the first-ever La Liga title in 1929?',
      ['Real Madrid', 'Athletic Bilbao', 'Barcelona', 'Valencia'],
      'Barcelona',
      [-1, -1, 10, -1],
    ),
    Question(
      'In which year did Atletico Madrid last win La Liga before their 2020-21 triumph?',
      ['2010', '2013', '2014', '2016'],
      '2014',
      [-1, -1, 10, -1],
    ),
    Question(
      'Which stadium is home to Real Madrid?',
      ['Camp Nou', 'Santiago Bernabéu', 'Metropolitano', 'Mestalla'],
      'Santiago Bernabéu',
      [-1, 10, -1, -1],
    ),
    Question(
      'Which club is known as "Los Leones" (The Lions)?',
      ['Espanyol', 'Athletic Bilbao', 'Real Sociedad', 'Osasuna'],
      'Athletic Bilbao',
      [-1, 10, -1, -1],
    ),
    Question(
      'Which La Liga club is owned by its fans (socios)?',
      [
        'Barcelona',
        'Real Madrid',
        'Both Barcelona and Real Madrid',
        'Atletico Madrid'
      ],
      'Both Barcelona and Real Madrid',
      [-1, -1, 10, -1],
    ),
    Question(
      'Who holds the record for most appearances in La Liga?',
      ['Iker Casillas', 'Sergio Ramos', 'Joaquín', 'Andoni Zubizarreta'],
      'Andoni Zubizarreta',
      [-1, -1, -1, 10],
    ),
    Question(
      'Which team is known as "Los Colchoneros" (The Mattress Makers)?',
      ['Real Madrid', 'Barcelona', 'Atletico Madrid', 'Valencia'],
      'Atletico Madrid',
      [-1, -1, 10, -1],
    ),
    Question(
      'Who won the Pichichi Trophy (top scorer) for the 2022-23 season?',
      ['Karim Benzema', 'Robert Lewandowski', 'Joselu', 'Antoine Griezmann'],
      'Robert Lewandowski',
      [-1, 10, -1, -1],
    ),
  ];

  int getQuestionsCount() {
    return _questionList.length;
  }

  void nextQuestion() {
    if (_questionNumber < _questionList.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionTextForCurrentQuestion() {
    return _questionList[_questionNumber].questionText;
  }

  List<String> getAnswers() {
    return _questionList[_questionNumber].answersList;
  }

  List<int> getScoreFromAnswers() {
    return _questionList[_questionNumber].answerWeight;
  }

  String getCorrectAnswer() {
    return _questionList[_questionNumber].correctAnswer;
  }

  bool didFinishQuiz() {
    return _questionNumber >= _questionList.length - 1;
  }

  void reset() {
    _questionNumber = 0;
    totalScore = 0;
    correctAnswers = 0;
  }

  int getCurrentQuestionNumber() {
    return _questionNumber + 1;
  }
}
