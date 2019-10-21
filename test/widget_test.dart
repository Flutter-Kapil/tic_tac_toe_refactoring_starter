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

  test('Test chnagePlayerIfGameIsNotOver is correct if board is empty', () {
    expect(currentPlayer, token.x);
    changePlayerIfGameIsNotOver();
    expect(currentPlayer, token.o);
  });

  test('Test chnagePlayerIfGameIsNotOver does nothing if its a draw', () {
    currentPlayer = token.x;
    board = [
      [token.x, token.o, token.x],
      [token.x, token.o, token.x],
      [token.o, token.x, token.o]
    ];
    changePlayerIfGameIsNotOver();
    expect(currentPlayer, token.x);
  });

  test('Test chnagePlayerIfGameIsNotOver does nothing if someone won already',
      () {
    currentPlayer = token.x;
    board = [
      [token.o, token.o, token.x],
      [token.x, token.o, token.x],
      [token.o, token.x, token.o]
    ];
    changePlayerIfGameIsNotOver();
    expect(currentPlayer, token.x);
  });
}
