import "package:flutter_test/flutter_test.dart";
import 'package:tic_tac_toe_starter/gamelogic.dart';

void main() {
  test("test fullBoard", () {
    List<List<token>> board = [
      [null, null, null],
      [null, null, null],
      [null, null, null]
    ];

    board[2][2] = token.x;

    expect(fullBoard(board), false);
  });
}
