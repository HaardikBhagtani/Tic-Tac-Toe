import 'package:flutter_test/flutter_test.dart';
import 'package:haardik_tic_tac_toe/ai/utils.dart';

void main() {
  test('Given function with board When isBoardFull is called Then whether board is full', () async {
    // ARRANGE
    final board = [0, 0, 0, 0, 0, 0, 0, 0, 0];

    // ACT
    final answer = Utils.isBoardFull(board);

    // ASSERT
    expect(answer, false);
  });
}
