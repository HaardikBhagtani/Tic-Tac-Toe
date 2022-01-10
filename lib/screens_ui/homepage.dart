import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haardik_tic_tac_toe/constants.dart';
import 'package:haardik_tic_tac_toe/model/authModel.dart';
import 'package:haardik_tic_tac_toe/storage/levels_repo.dart';
import '../splash.dart';
import 'game_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GameLevelRepository? _gameLevelRepository;

  String? level;

  check() async {
    int? res = await _gameLevelRepository?.levelsCreated();
    if (kDebugMode) {
      print(res);
    }
    if (res != 1) {
      if (kDebugMode) {
        print('created');
      }
      await _gameLevelRepository?.levelsCreatedAndInitialized();
    }
    var level1 = await _gameLevelRepository?.getLevel();
    setState(() {
      level = level1;
    });
    if (kDebugMode) {
      print(level);
    }
  }

  bool checkDone = false;
  AuthModel _authModel = AuthModel();

  @override
  void initState() {
    _gameLevelRepository = GameLevelRepository();
    check().whenComplete(() {
      setState(() {
        checkDone = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return checkDone
        ? Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Tic Tac Toe',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: kMainColor,
                  ),
                ),
              ),
              centerTitle: true,
              actions: [
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: kMainColor,
                  ),
                  onSelected: (selected) {
                    _authModel.logOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Splash()));
                  },
                  itemBuilder: (_) => <PopupMenuItem<String>>[
                    PopupMenuItem<String>(
                      child: Text('Log Out'),
                      value: 'Log Out',
                      onTap: () {
                        Navigator.pop(context, "Log Out");
                      },
                    ),
                  ],
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'MODE',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: kMainColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    side: BorderSide(color: kMainColor, width: 2),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(kMainColor),
                              ),
                              onPressed: () async {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    size: 28,
                                    color: Color(0xFFFFDB1E),
                                  ),
                                  Text(
                                    "VS",
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        color: Color(0xFFFFDB1E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.monitor,
                                    size: 28,
                                    color: Color(0xFFFFDB1E),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    side: BorderSide(color: kMainColor, width: 2),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              ),
                              onPressed: () async {
                                Fluttertoast.showToast(
                                  msg: 'Mode Coming Soon',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    size: 28,
                                    color: kMainColor,
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
                                  Icon(
                                    Icons.person_outline,
                                    size: 28,
                                    color: kMainColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'LEVEL',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: kMainColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    side: BorderSide(color: kMainColor, width: 2),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all<Color>(level == _gameLevelRepository?.easy ? kMainColor : Colors.white),
                              ),
                              onPressed: () async {
                                setState(() {
                                  if (level == _gameLevelRepository?.easy) {
                                    level = _gameLevelRepository?.difficult;
                                  } else {
                                    level = _gameLevelRepository?.easy;
                                  }
                                });
                                await _gameLevelRepository?.changeLevel(level!);
                                if (kDebugMode) {
                                  print(await _gameLevelRepository?.getLevel());
                                }
                              },
                              child: Text(
                                "${_gameLevelRepository?.easy}",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    color: level == _gameLevelRepository?.easy ? Color(0xFFFFDB1E) : kMainColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    side: BorderSide(color: kMainColor, width: 2),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(level == _gameLevelRepository?.difficult ? kMainColor : Colors.white),
                              ),
                              onPressed: () async {
                                setState(() {
                                  if (level == _gameLevelRepository?.easy) {
                                    level = _gameLevelRepository?.difficult;
                                  } else {
                                    level = _gameLevelRepository?.easy;
                                  }
                                });
                                await _gameLevelRepository?.changeLevel(level!);
                                if (kDebugMode) {
                                  print(await _gameLevelRepository?.getLevel());
                                }
                              },
                              child: Text(
                                "${_gameLevelRepository?.difficult}",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    color: level == _gameLevelRepository?.difficult ? Color(0xFFFFDB1E) : kMainColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(
                            side: BorderSide(color: kMainColor, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GamePage(),
                          ),
                        );
                      },
                      child: Text(
                        "PLAY",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: kMainColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
  }
}
