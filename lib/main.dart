import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  runApp(GameWidget());
}

class GameWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final game = SpaceShooterGame();
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details)
    {
        game.OnPlayerMove(details.delta);
    },
      child: Container(
        color: Color(0xFFFFFFFF),
        child: game.widget,

      ),
    );
  }
}

Paint _paint = Paint()..color = Color(0xFFFFFFFF);

class GameObject {
  Rect position;

  void render(Canvas canvas){
    canvas.drawRect(position, _paint);
  }
}

class SpaceShooterGame extends Game{

  GameObject player;

  SpaceShooterGame(){
    player = GameObject()
        ..position = Rect.fromLTWH(200, 200, 100, 100);
  }

  void OnPlayerMove(Offset delta){

      player.position = player.position.translate(delta.dx, delta.dy);

  }
  
  @override
  void update(double dt){

  }

  @override
  void render(Canvas canvas){
    
    player.render(canvas);
    
  }
}

