import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:fluppy_bird/components/pipe.dart';

import '../constants/constants.dart';
import '../pages/game.dart';
import 'grounds.dart';

class Bird extends SpriteComponent with CollisionCallbacks{
  Bird()
    : super(
        position: Vector2(birdStartX, birdStartY),
        size: Vector2(birdWidth, birdHeight),
      );

  //physical world properties
  double velocity = 0;
  // final double jumpsStrength = -300;
  // const double gravity = 800;
  // const double jumpStrength = -400;

  @override
  FutureOr<void> onLoad() async {
    //load bird image
    sprite = await Sprite.load('bird.png');

    //add a hitbox
    add(RectangleHitbox());

  }

  //Jump / Flap

  void flap() {
    velocity = jumpStrength;
  }

  // Update
  @override
  void update(double dt) {
    velocity += gravity * dt;

    // Update the bird's vertical position
    position.y += velocity * dt;

    // Prevent the bird from going above the screen
    if (position.y < 0) {
      position.y = 0;
      velocity = 0;
    }
  }

  //Collision with another object

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);


    //check if bird collisions with ground

    if (other is Grounds) {
      (parent as FlappyBirdGame).gameOver();
    }

    //collision with pipes
    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }


  }

}
