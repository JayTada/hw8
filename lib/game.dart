import 'dart:math';

import 'dart:math';

class game {
  static const maxRandom = 100;
  int? _answer;

  int Count = 0;
  int sum=0;

  game(var mainGame) {

    _answer=mainGame;
  }

  int doGuess(int num) {
    if (num > _answer!) {

      return 1;

    } else if (num < _answer!) {

      return -1;
    } else {

      return 0;
    }
  }
}
