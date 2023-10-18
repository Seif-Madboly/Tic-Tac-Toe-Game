import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/game_logic.dart';

import 'color.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = "X";
  Game game = Game();
  List<int> scoreboard = [0,0,0,0,0,0,0,0];
  bool gameOver = false;
  String result = "";
  int turn = 0;

  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's $lastValue turn".toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 58,
            ),
          ),
          SizedBox(
            height: boardWidth * 0.2,
          ),
          SizedBox(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
                crossAxisCount: Game.boardLenth ~/ 3,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: List.generate(Game.boardLenth, (index) {
                  return InkWell(
                    onTap: gameOver
                        ? null
                        : () {
                            if (game.board![index] == "") {
                              setState(() {
                                game.board![index] = lastValue;
                                turn ++;
                                gameOver = game.winnerCheck(lastValue, index, scoreboard, 3);
                                if(gameOver){
                                  result = "$lastValue is the winner";
                                }else if (!gameOver && turn == 9) {
                                  result = "It's a Draw!";
                                  gameOver = true;
                                }
                                if (lastValue == "X") {
                                  lastValue = "O";
                                } else {
                                  lastValue = "X";
                                }
                              });
                            }
                          },
                    child: Container(
                      width: Game.blocSize,
                      height: Game.blocSize,
                      decoration: BoxDecoration(
                          color: MainColor.secondaryColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Text(
                          game.board![index],
                          style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.blue
                                : Colors.pink,
                            fontSize: 64.0,
                          ),
                        ),
                      ),
                    ),
                  );
                })),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 45
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: MainColor.accentColor
            ),
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn =0;
                result = "";
                scoreboard = [0,0,0,0,0,0,0,0];
              });
            },
            icon: const Icon(Icons.replay,
             ),
            label: const Text("Repeat The Game"),
          )
        ],
      ),
    );
  }
}
