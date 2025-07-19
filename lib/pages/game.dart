import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:fluppy_bird/components/bird.dart';
import 'package:fluppy_bird/constants/constants.dart';
import 'package:fluppy_bird/pages/background.dart';
import 'package:flutter/material.dart';

import 'grounds.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Grounds grounds;

  @override
  FutureOr<void> onLoad() {
    //Load the background
    background = Background(size);
    add(background);

    //Load the bird
    bird = Bird();
    add(bird);

    //load grounds
    grounds = Grounds();
    add(grounds);
  }

  @override
  void onTap() {
    bird.flap();
  }

  //GameOver

  bool isGameOver = false;

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    //Show Dialog box

    showDialog(
      context: buildContext!,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        actions: [
          TextButton(
            onPressed: () {
              //pop the game
              Navigator.pop(context);

              //reset game
              resetGame();
            },
            child: const Text("Play Again"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartY, birdStartY);
    bird.velocity = 0;
    isGameOver =false;
    resumeEngine();
  }
}
