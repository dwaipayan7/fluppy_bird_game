import 'dart:async';

import 'package:flame/components.dart';

class Bird extends SpriteComponent {
  Bird() : super(position: Vector2(100, 100), size: Vector2(60, 40));

  //physical world properties
  double velocity = 0;
  final double gravity = 800;
  final double jumpsStrength = -300;

  @override
  FutureOr<void> onLoad() async {
    //load bird image
    sprite = await Sprite.load('bird.png');
  }

  //Jump / Flap

  void flap() {
    velocity = jumpsStrength;
  }

  //Update

  @override
  void update(double dt) {
    velocity += gravity * dt;
    //update the birds position on current velocity

    position.y += velocity * dt;

  }
}
