import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:fluppy_bird/components/bird.dart';
import 'package:fluppy_bird/components/pipe.dart';         // ✅ Needed for reset
import 'package:fluppy_bird/components/pipe_manager.dart';
import 'package:fluppy_bird/components/background.dart';
import 'package:fluppy_bird/components/grounds.dart';

import 'package:fluppy_bird/constants/constants.dart';

class FlappyBirdGame extends FlameGame
    with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Grounds grounds;
  late PipeManager pipeManager;

  bool isGameOver = false;

  @override
  FutureOr<void> onLoad() {
    // Load the background
    background = Background(size);
    add(background);

    // Load the bird
    bird = Bird();
    add(bird);

    // Load the ground
    grounds = Grounds();
    add(grounds);

    // Load pipe manager
    pipeManager = PipeManager();
    add(pipeManager);
  }

  @override
  void onTap() {
    bird.flap();
  }

  // Game Over handler
  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    // Show game over dialog
    if (buildContext != null) {
      showDialog(
        context: buildContext!,
        builder: (context) => AlertDialog(
          title: const Text("Game Over"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                resetGame(); // Reset the game
              },
              child: const Text("Play Again"),
            ),
          ],
        ),
      );
    }
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    isGameOver = false;

    // Remove all pipes
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());

    resumeEngine();
  }
}
