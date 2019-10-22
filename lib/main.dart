import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'gamelogic.dart';

//import 'package:flutter/animation.dart';

void main() {
  runApp(MaterialApp(
    home: TicTacToePage(),
  ));
}

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage>
    with SingleTickerProviderStateMixin {
      bool changeWinningStatusColor = false;
  Widget getIconFromToken(token t) {
    if (t == token.o) {
      return Icon(
        Icons.radio_button_unchecked,
        size: 75,
        color: Colors.white,
      );
    }
    if (t == token.x) {
      return Icon(
        Icons.close,
        size: 75,
        color: Colors.white,
      );
    } else
      return null;
  }

  Color getColorFromBool(int row, int col) {
    return colorBoard[row][col]
        ? Colors.yellow.withOpacity(0.2)
        : Colors.white30;
  }

  Widget singleExpandedBox(int row, int col) {
    return Expanded(
      child: OneBox(
        buttonChild: getIconFromToken(board[row][col]),
        colors: getColorFromBool(row, col),
        onPressed: () {
          updateBox(row, col);
          setState(() {});
        },
      ),
    );
  }

  Widget expandedRow(int row) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          singleExpandedBox(row, 0),
          singleExpandedBox(row, 1),
          singleExpandedBox(row, 2),
        ],
      ),
    );
  }

  AnimationController statusTextController;
  double endTweenValue = 2.0;

  @override
  void initState() {
    statusTextController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    statusTextController
        .addStatusListener((AnimationStatus buttonAnimationStatus) {
      if (buttonAnimationStatus == AnimationStatus.completed) {
        statusTextController.reverse();
      } else if (buttonAnimationStatus == AnimationStatus.dismissed) {
        statusTextController.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation smoothAnimation = CurvedAnimation(
        parent: statusTextController, curve: Curves.easeInOutBack);

    return Scaffold(
      backgroundColor: Color(0xFFD6AA7C),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background08.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Tic-Tac-Toe",
                  style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      fontFamily: 'Quicksand'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: ScaleTransition(
                  scale: Tween(begin: 1.0, end: endTweenValue)
                      .animate(smoothAnimation),
                  child: Text(
                    getCurrentStatus(changeWinningStatusColor,endTweenValue, 
                      statusTextController.forward),
                    style: TextStyle(
                        fontSize: 25,
                        color: changeWinningStatusColor?Colors.yellow:Colors.white.withOpacity(0.6),
                        fontFamily: 'Quicksand'),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  children: <Widget>[
                    expandedRow(0),
                    expandedRow(1),
                    expandedRow(2),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: FlatButton(
                        color: Color(0xFF848AC1),
                        onPressed: () {
                          gameReset();
                          // statusTextController.dispose();
                        print('test');
                          changeWinningStatusColor = false;
                          setState(() {});
                        },
                        child: Text("Reset",
                            style:
                                TextStyle(fontSize: 25, color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
  void updateBox(int r, int c) {
    if (legitMove(board[r][c])) {
      board[r][c] = currentPlayer;
      changePlayerIfGameIsNotOver();
    }
  }
}

class OneBox extends StatefulWidget {
  final Widget buttonChild;
  final Function onPressed;
  final Color colors;
  OneBox(
      {this.buttonChild = const Text(''),
      this.onPressed,
      this.colors = Colors.white24});

  @override
  _OneBoxState createState() => _OneBoxState();
}

class _OneBoxState extends State<OneBox> with SingleTickerProviderStateMixin {
  AnimationController myController;

  @override
  void initState() {
    myController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation smoothAnimation =
        CurvedAnimation(parent: myController, curve: Curves.bounceOut);
    return GestureDetector(
      onTap: () {
        widget.onPressed();
        myController.forward();
      },
      child: Container(
        alignment: Alignment.center,
        child: FadeTransition(
          opacity: myController,
                  child: ScaleTransition(
              scale: Tween(begin: 2.5, end: 1.0).animate(smoothAnimation),
              child: widget.buttonChild),
        ),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: widget.colors,
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
      ),
    );
  }
}
