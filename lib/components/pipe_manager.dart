import 'dart:math';

import 'package:flame/components.dart';
import 'package:fluppy_bird/components/pipe.dart';
import 'package:fluppy_bird/constants/constants.dart';
import 'package:fluppy_bird/pages/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  // update --> Every Seconds

  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    // TODO: implement update
    pipeSpawnTimer += dt;
    const double pipeInterval = 2;

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;
    const double pipeGap = 150;
    const double minPipeHeight = 50;
    const double pipeWidth = 60;

    //calculate pipe height

    //max possible height
    final double maxPipeHeight =
        screenHeight - groundsHeight - pipeGap - minPipeHeight;


    //height of the bottom pipe

    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);


    //height of the top pipe
    final double topPipeHeight = screenHeight - groundsHeight - pipeGap - bottomPipeHeight;


    //Create bottom pipe

    final bottomPipe = Pipe(Vector2(gameRef.size.x, screenHeight - groundsHeight - bottomPipeHeight),
        Vector2(pipeWidth, bottomPipeHeight),
        isTopPipe: false
    );

    //create top pipe

    final topPipe = Pipe(
        Vector2(gameRef.size.x, 0),
        Vector2(pipeWidth, topPipeHeight),
        isTopPipe: true
    );


    //add both pipes
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);

  }

}
