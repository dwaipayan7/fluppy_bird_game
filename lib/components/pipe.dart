import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:fluppy_bird/constants/constants.dart';
import 'package:fluppy_bird/pages/game.dart';

class Pipe extends SpriteComponent with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  final bool isTopPipe;

  bool isScored = false;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    // Load the correct sprite based on pipe position
    sprite = await Sprite.load(isTopPipe ? 'pipe_top.png' : 'pipe_bottom.png');

    // ✅ Add hitbox for collision detection
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // Move the pipe left over time
    position.x -= groundsScrollSpeed * dt;

    //check if the bird has passed the pipe
    if(!isScored && position.x + size.x < gameRef.bird.position.x){
      isScored = true;

      if(isTopPipe){
        gameRef.incrementScore();
      }

    }

    // Remove pipe if it goes off-screen
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
