import 'package:flutter/material.dart';

enum token { x, o }

List<List<token>> board = [
  [null, null, null],
  [null, null, null],
  [null, null, null]
];

// initial list of colors assigned to boxes on board
List<List<Color>> colorBoard = [
  [Colors.white24, Colors.white24, Colors.white24],
  [Colors.white24, Colors.white24, Colors.white24],
  [Colors.white24, Colors.white24, Colors.white24]
];

//  takes an icon, checks if
bool legitMove(token t) {
  return t == null && !winnerCheck(board);
}

//default parameters
String currentPlayer = 'Player X Move'; //X will always be player 1
Icon xIcon = Icon(
  Icons.close,
  size: 70,
  color: Colors.white,
);
Icon oIcon = Icon(
  Icons.radio_button_unchecked,
  size: 70,
);
Icon playerIcon;

//function to change player based on currentPlayer value which is a string,
changePlayer(String x) {
  if (x == 'Player X Move') {
    currentPlayer = 'Player O Move';
  } else if (x == 'Player O Move') {
    currentPlayer = 'Player X Move';
  }
}

Color winningColor = Colors.yellow.withOpacity(0.2);
void gameReset() {
  board = [
    [null, null, null],
    [null, null, null],
    [null, null, null]
  ];
  colorBoard = [
    [Colors.white24, Colors.white24, Colors.white24],
    [Colors.white24, Colors.white24, Colors.white24],
    [Colors.white24, Colors.white24, Colors.white24]
  ];
  currentPlayer = 'Player X Move';
}

bool fullBoard(List<List<token>> board) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == null) {
        return false;
      }
    }
  }
  return true;
}

bool winnerCheck(List<List<token>> board) {
  for (int i = 0; i < 3; i++) {
    if (board[i][0] == token.x &&
        board[i][1] == token.x &&
        board[i][2] == token.x) {
      colorBoard[i][0] = winningColor;
      colorBoard[i][1] = winningColor;
      colorBoard[i][2] = winningColor;
      return true;
    }
    if (board[0][i] == token.x &&
        board[1][i] == token.x &&
        board[2][i] == token.x) {
      colorBoard[0][i] = winningColor;
      colorBoard[1][i] = winningColor;
      colorBoard[2][i] = winningColor;
      return true;
    }
    if (board[i][0] == token.o &&
        board[i][1] == token.o &&
        board[i][2] == token.o) {
      colorBoard[i][0] = winningColor;
      colorBoard[i][1] = winningColor;
      colorBoard[i][2] = winningColor;
      return true;
    }
    if (board[0][i] == token.o &&
        board[1][i] == token.o &&
        board[2][i] == token.o) {
      colorBoard[0][i] = winningColor;
      colorBoard[1][i] = winningColor;
      colorBoard[2][i] = winningColor;
      return true;
    }
  }
  if (board[0][0] == token.x &&
      board[1][1] == token.x &&
      board[2][2] == token.x) {
    colorBoard[0][0] = winningColor;
    colorBoard[1][1] = winningColor;
    colorBoard[2][2] = winningColor;
    return true;
  }
  if (board[0][2] == token.x &&
      board[1][1] == token.x &&
      board[2][0] == token.x) {
    colorBoard[0][2] = winningColor;
    colorBoard[1][1] = winningColor;
    colorBoard[2][0] = winningColor;
    return true;
  }
  if (board[0][0] == token.o &&
      board[1][1] == token.o &&
      board[2][2] == token.o) {
    colorBoard[0][0] = winningColor;
    colorBoard[1][1] = winningColor;
    colorBoard[2][2] = winningColor;
    return true;
  }
  if (board[0][2] == token.o &&
      board[1][1] == token.o &&
      board[2][0] == token.o) {
    colorBoard[0][2] = winningColor;
    colorBoard[1][1] = winningColor;
    colorBoard[2][0] = winningColor;
    return true;
  } else {
    return false;
  }
}
