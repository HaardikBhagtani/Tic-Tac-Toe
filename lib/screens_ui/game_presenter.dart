import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:haardik_tic_tac_toe/ai/ai.dart';
import 'package:haardik_tic_tac_toe/ai/utils.dart';
import 'package:haardik_tic_tac_toe/storage/levels_repo.dart';

class GamePresenter {
  // callbacks into our UI
  void Function(int idx) showMoveOnUi;
  void Function(int winningPlayer) showGameEnd;
  void Function(bool aiPlay) aiPlaying;

  //late GameInfoRepository _repository;
  late Ai _aiPlayer;

  GamePresenter(this.showMoveOnUi, this.showGameEnd, this.aiPlaying) {
    //_repository = GameInfoRepository.getInstance();
    _aiPlayer = Ai();
  }

  void onHumanPlayed(List<int> board) async {
    aiPlaying(true);
    // evaluate the board after the human player
    int evaluation = Utils.evaluateBoard(board);
    if (evaluation != Ai.noWinnersYet) {
      onGameEnd(evaluation);
      return;
    }
    GameLevelRepository _gameLevelRepository = GameLevelRepository();

    int aiMove;

    if (await _gameLevelRepository.getLevel() == _gameLevelRepository.easy) {
      /// Level- EASY
      aiMove = Ai.randomPlay(board, Ai.aiPlayer);
      Timer(Duration(seconds: 2), () {
        print(" This line is execute after 2 seconds");
        // do the next move
        board[aiMove] = Ai.aiPlayer;
        // evaluate the board after the AI player move

        evaluation = Utils.evaluateBoard(board);
        if (evaluation != Ai.noWinnersYet) {
          onGameEnd(evaluation);
        } else {
          showMoveOnUi(aiMove);
        }
        aiPlaying(false);
      });
    } else {
      /// LEVEL- DIFFICULT
      aiMove = await Future(() => _aiPlayer.play(board, Ai.aiPlayer));
      Timer(Duration(seconds: 3), () {
        if (kDebugMode) {
          print(" This line is execute after 3 seconds");
        }
        // do the next move
        board[aiMove] = Ai.aiPlayer;
        // evaluate the board after the AI player move

        evaluation = Utils.evaluateBoard(board);
        if (evaluation != Ai.noWinnersYet) {
          onGameEnd(evaluation);
        } else {
          showMoveOnUi(aiMove);
        }
        aiPlaying(false);
      });
    }
  }

  void onGameEnd(int winner) {
    showGameEnd(winner);
  }
}
