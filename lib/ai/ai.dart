import 'dart:math';
import 'package:haardik_tic_tac_toe/ai/utils.dart';

class Ai {
  // evaluation condition values
  static const int human = 1;
  static const int aiPlayer = -1;
  static const int noWinnersYet = 0;
  static const int draw = 2;

  static const int emptySpace = 0;
  static const symbols = {emptySpace: "", human: "X", aiPlayer: "O"};

  // arbitrary values for winning, draw and losing conditions
  static const int winScore = 100;
  static const int drawScore = 0;
  static const int loseScore = -100;

  static const List<List<int>> winConditionList = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  /// Returns the optimal move based on the state of the board.
  int play(List<int> board, int currentPlayer) {
    return _getBestMove(board, currentPlayer).move;
  }

  /// Returns the best possible score for a certain board condition.
  /// This method implements the stopping condition.
  int _getBestScore(List<int> board, int currentPlayer) {
    int evaluation = Utils.evaluateBoard(board);

    if (evaluation == currentPlayer) return winScore;

    if (evaluation == draw) return drawScore;

    if (evaluation == Utils.flipPlayer(currentPlayer)) {
      return loseScore;
    }

    return _getBestMove(board, currentPlayer).score;
  }

  /// This is where the actual Minimax algorithm is implemented
  Move _getBestMove(List<int> board, int currentPlayer) {
    // try all possible moves
    List<int> newBoard;
    // will contain our next best score
    Move bestMove = Move(score: -10000, move: -1);

    for (int currentMove = 0; currentMove < board.length; currentMove++) {
      if (!Utils.isMoveLegal(board, currentMove)) continue;

      // we need a copy of the initial board so we don't pollute our real board
      newBoard = List.from(board);

      // make the move
      newBoard[currentMove] = currentPlayer;

      // solve for the next player
      // what is a good score for the opposite player is opposite of good score for us
      int nextScore = -_getBestScore(newBoard, Utils.flipPlayer(currentPlayer));

      // check if the current move is better than our best found move
      if (nextScore > bestMove.score) {
        bestMove.score = nextScore;
        bestMove.move = currentMove;
      }
    }

    return bestMove;
  }

  /// Playing Random move, for LEVEL- EASY
  static int randomPlay(List<int> board, int currentPlayer) {
    int randomMove = Random().nextInt(9);
    while (!Utils.isMoveLegal(board, randomMove)) {
      randomMove = Random().nextInt(9);
    }
    return randomMove;
  }
}

class Move {
  int score;
  int move;

  Move({required this.score, required this.move});
}
