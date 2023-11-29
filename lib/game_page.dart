import 'package:cris_crass_game/app_color.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool oTurn = true;
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  final AppColors _colors = AppColors();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _colors.backGround,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  width: 40,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                    color: _colors.backGround,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: _colors.white.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(-4, -4),
                      ),
                      BoxShadow(
                        color: _colors.black.withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(6, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Player X',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        xScore.toString(),
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: size.width - 40,
              width: size.width - 40,
              child: GridView.builder(
                  itemCount: 9,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.15,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _colors.backGround,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: _colors.white.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(-4, -4),
                            ),
                            BoxShadow(
                              color: _colors.black.withOpacity(0.4),
                              blurRadius: 16,
                              offset: const Offset(6, 6),
                            ),
                          ],
                        ),
                        child: displayElement[index] == "X"
                            ? const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 50,
                              )
                            : displayElement[index] == "O"
                                ? const Icon(
                                    Icons.circle_outlined,
                                    color: Colors.yellow,
                                    size: 50,
                                  )
                                : const SizedBox(),
                      ),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                    color: _colors.backGround,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: _colors.white.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(-4, -4),
                      ),
                      BoxShadow(
                        color: _colors.black.withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(6, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Player O',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        oScore.toString(),
                        style:
                            const TextStyle(fontSize: 18, color: Colors.yellow),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: _clearScoreBoard,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: _colors.backGround,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: _colors.white.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(-4, -4),
                      ),
                      BoxShadow(
                        color: _colors.black.withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(6, 6),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Clear Score Board",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      _showWinDialog(displayElement[3]);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      _showWinDialog(displayElement[6]);
    }

    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      _showWinDialog(displayElement[1]);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    }

    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              _clearBoard();
              return true;
            },
            child: AlertDialog(
              backgroundColor: _colors.backGround,
              content: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/win.gif',
                    height: 180,
                    width: 160,
                    fit: BoxFit.fill,
                  ),
                  winner ==  "X" ? const Icon(
                    Icons.clear,
                    size: 32,
                    color: Colors.red,
                  ) : const Icon(
                    Icons.circle_outlined,
                    size: 32,
                    color: Colors.yellow,
                  ),
                ],
              ),
            ),
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              _clearBoard();
              return true;
            },
            child: AlertDialog(
              backgroundColor: _colors.backGround,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/draw.gif',
                    height: 180,
                    width: 160,
                    fit: BoxFit.fill,
                  ),
                  const Text(
                    "firse",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });

    filledBoxes = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
