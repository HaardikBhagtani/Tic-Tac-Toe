import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haardik_tic_tac_toe/ai/ai.dart';
import 'package:haardik_tic_tac_toe/storage/levels_repo.dart';
import '../constants.dart';
import 'field.dart';
import 'game_presenter.dart';

class GamePage extends StatefulWidget {
  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  late List<int> board;
  late int _currentPlayer;
  bool aiPlaying = false;

  late GamePresenter _presenter;

  GamePageState() {
    _presenter = GamePresenter(_movePlayed, _onGameEnd, aiPlay);
  }
  void aiPlay(bool aiP) {
    setState(() {
      aiPlaying = aiP;
    });
  }

  void _onGameEnd(int winner) {
    var title = "Game over!";
    var content = "You lose :(";
    switch (winner) {
      case Ai.human: // will never happen :)
        title = "Congratulations!";
        content = "You managed to beat an unbeatable AI!";
        break;
      case Ai.aiPlayer:
        title = "Game Over!";
        content = "You lose :(";
        break;
      default:
        title = "Draw!";
        content = "No winners here.";
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title, style: GoogleFonts.roboto()),
            content: Text(content, style: GoogleFonts.roboto()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    reinitialize();
                    Navigator.of(context).pop();
                  });
                },
                child: Text(
                  "Restart",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: kMainColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void _movePlayed(int idx) {
    setState(() {
      board[idx] = _currentPlayer;

      if (_currentPlayer == Ai.human) {
        // switch to AI player
        _currentPlayer = Ai.aiPlayer;
        _presenter.onHumanPlayed(board);
      } else {
        _currentPlayer = Ai.human;
      }
    });
  }

  getGameLevel() async {
    GameLevelRepository _gameLevelRepository = GameLevelRepository();
    level = (await _gameLevelRepository.getLevel())!;
  }

  String? getSymbolForIdx(int idx) {
    return Ai.symbols[board[idx]];
  }

  String? level;
  bool ready = false;

  @override
  void initState() {
    getGameLevel().whenComplete(() {
      setState(() {
        ready = true;
      });
    });
    super.initState();
    reinitialize();
  }

  void reinitialize() {
    _currentPlayer = Ai.human;
    // generate the initial board
    board = List.generate(9, (idx) => 0);
  }

  @override
  Widget build(BuildContext context) {
    return ready
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Image.asset(
                  'assets/union.png',
                  scale: 0.7,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.rule,
                    color: kMainColor,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Rules of Game',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: kMainColor,
                                ),
                              ),
                            ),
                            content: Text(
                              '1. The game is played on a grid that\'s 3 squares by 3 squares.\n2. You are X, your friend (or the computer in this case) is O. Players take turns putting their marks in empty squares.\n3. The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner.\n4. When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.',
                              style: GoogleFonts.roboto(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Got It',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: kMainColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 25, top: 40, right: 25, bottom: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: aiPlaying ? 30 : 50,
                        color: kMainColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "VS",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: kMainColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.monitor,
                        size: aiPlaying ? 50 : 30,
                        color: kMainColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "$level",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: kMainColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      // generate the widgets that will display the board
                      children: List.generate(9, (idx) {
                        return Field(idx: aiPlaying ? 10 : idx, onTap: _movePlayed, playerSymbol: getSymbolForIdx(idx)!);
                      }),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const CircularProgressIndicator();
  }
}
