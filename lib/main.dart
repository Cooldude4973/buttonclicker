import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: buttonClicker(),
    );
  }
}

class buttonClicker extends StatefulWidget {
  const buttonClicker({super.key});

  @override
  State<buttonClicker> createState() => _buttonClickerState();
}

class _buttonClickerState extends State<buttonClicker> {
  int counter = 0;
  bool isStarted = false;
  String second = "00";
  Timer? mainTimer;
  int finalScore = 0;
  int maxScore = 0;
  double buttonW = 20;
  double buttonH = 20;

  void onLevelChoosed(int n) {
    if (n == 1) {
      setState(() {
        buttonW = 20;
        buttonH = 20;
      });
    } else if (n == 2) {
      setState(() {
        buttonW = 80;
        buttonH = 80;
      });
    } else if (n == 3) {
      setState(() {
        buttonW = 200;
        buttonH = 200;
      });
    }
  }

  void onClicked(int num) {
    int seconds = 0;
    isStarted = !isStarted;
    if (!isStarted) {
      setState(() {
        mainTimer!.cancel();
        second = "00";
      });
    }
    if (isStarted) {
      mainTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        seconds++;

        if (seconds == num) {
          setState(() {
            second = "00";
            isStarted = false;
            finalScore = counter;
            maxScore = max(maxScore, finalScore);
            counter = 0;
            mainTimer!.cancel();
          });
        }
        setState(() {
          second = (seconds < 10) ? "0$seconds" : "$seconds";
        });
      });
    }
  }

  void onPressedMe() {
    if (isStarted) {
      setState(() {
        counter++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Clicker Game'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Text(
              'Timer : ${second}',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                onPressedMe();
              },
              child: Text(
                "Press Me",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: CircleBorder(),
                  fixedSize: Size(buttonW!, buttonH!),
                  minimumSize: Size(20, 40)),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Highest Score is : ${(maxScore == 0) ? "No Max Score" : "$maxScore"}',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  backgroundColor: Colors.yellow),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Your Final Score is : ${(finalScore == 0) ? "No Final Score" : "$finalScore"}',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  backgroundColor: Colors.yellow),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              '$counter',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      onClicked(10);
                    },
                    child: Text(
                      '10 secs',
                      style: TextStyle(color: Colors.black),
                    ),
                    shape: StadiumBorder(side: BorderSide(color: Colors.red)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      onClicked(20);
                    },
                    child: Text(
                      '20 secs',
                      style: TextStyle(color: Colors.black),
                    ),
                    shape: StadiumBorder(side: BorderSide(color: Colors.red)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      onClicked(30);
                    },
                    child: Text(
                      '30 secs',
                      style: TextStyle(color: Colors.black),
                    ),
                    shape: StadiumBorder(side: BorderSide(color: Colors.red)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      onLevelChoosed(3);
                    },
                    child: Text('Easy'),
                    shape: StadiumBorder(side: BorderSide(color: Colors.green)),
                    fillColor: Colors.green,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      onLevelChoosed(2);
                    },
                    child: Text('Medium'),
                    shape:
                        StadiumBorder(side: BorderSide(color: Colors.yellow)),
                    fillColor: Colors.yellow,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      onLevelChoosed(1);
                    },
                    child: Text('Hard'),
                    shape: StadiumBorder(side: BorderSide(color: Colors.red)),
                    fillColor: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
