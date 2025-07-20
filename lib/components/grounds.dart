import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:fluppy_bird/constants/constants.dart';
import 'package:fluppy_bird/pages/game.dart';

class Grounds extends SpriteComponent with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Grounds() : super();

  //Load

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(2 * gameRef.size.x, groundsHeight);
    position = Vector2(0, gameRef.size.y - groundsHeight);

    //load ground sprite image
    sprite = await Sprite.load('ground.png');

    //add a collision box
    add(RectangleHitbox());

  }


  //Update

  @override
  void update(double dt) {
    position.x -= groundsScrollSpeed * dt;

    //reset to infinity scrolling
    //if half the ground has been passes reset
    if (position.x <= -gameRef.size.x) {
      position.x = 0;
    }

  }



}
