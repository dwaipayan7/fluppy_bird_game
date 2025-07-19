import 'dart:async';

import 'package:flame/game.dart';
import 'package:fluppy_bird/components/bird.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame{

  late Bird bird;


  @override
  FutureOr<void> onLoad() {
    bird = Bird();
    add(bird);

  }

}