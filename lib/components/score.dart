import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:fluppy_bird/pages/game.dart';
import 'package:flutter/material.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBirdGame> {
  ScoreText() : super(text: '0', textRenderer: TextPaint(
    style: TextStyle(
      fontSize: 50,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    )
  ));

  //load
  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    //Set the position to lower middle

    position = Vector2(
      (gameRef.size.x - size.x) / 2,
      gameRef.size.y - size.y - 50,
    );
  }

  @override
  void update(double dt) {
    final newText = gameRef.score.toString();

    if (text != newText) {
      text = newText;
    }
  }
}
