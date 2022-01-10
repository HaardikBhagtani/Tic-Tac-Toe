import 'package:flutter/material.dart';

import '../constants.dart';

class Field extends StatelessWidget {
  final int idx;
  final Function(int idx) onTap;
  final String playerSymbol;

  const Field({Key? key, required this.idx, required this.onTap, required this.playerSymbol}) : super(key: key);

  final BorderSide _borderSide = const BorderSide(color: Colors.black, width: 0.4);
  final BorderSide _borderOutSide = const BorderSide(color: Colors.black, width: 1.5);

  void _handleTap() {
    // only send tap events if the field is empty
    if (playerSymbol == "" && idx != 10) onTap(idx);
  }

  /// Returns a border to draw depending on this field index.
  Border _determineBorder() {
    Border determinedBorder = Border.all();

    switch (idx) {
      case 0:
        determinedBorder = Border(bottom: _borderSide, right: _borderSide, top: _borderOutSide, left: _borderOutSide);
        break;
      case 1:
        determinedBorder = Border(left: _borderSide, bottom: _borderSide, right: _borderSide, top: _borderOutSide);
        break;
      case 2:
        determinedBorder = Border(left: _borderSide, bottom: _borderSide, top: _borderOutSide, right: _borderOutSide);
        break;
      case 3:
        determinedBorder = Border(bottom: _borderSide, right: _borderSide, top: _borderSide, left: _borderOutSide);
        break;
      case 4:
        determinedBorder = Border(left: _borderSide, bottom: _borderSide, right: _borderSide, top: _borderSide);
        break;
      case 5:
        determinedBorder = Border(left: _borderSide, bottom: _borderSide, top: _borderSide, right: _borderOutSide);
        break;
      case 6:
        determinedBorder = Border(right: _borderSide, top: _borderSide, left: _borderOutSide, bottom: _borderOutSide);
        break;
      case 7:
        determinedBorder = Border(left: _borderSide, top: _borderSide, right: _borderSide, bottom: _borderOutSide);
        break;
      case 8:
        determinedBorder = Border(left: _borderSide, top: _borderSide, right: _borderOutSide, bottom: _borderOutSide);
        break;
    }

    return determinedBorder;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        margin: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(border: _determineBorder(), color: Color(0xAAFFDB1E)),
        child: Center(
          child: Text(
            playerSymbol,
            style: const TextStyle(
              fontSize: 50,
              color: kMainColor,
            ),
          ),
        ),
      ),
    );
  }
}
