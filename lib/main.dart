import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/time.dart';

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

  Timer enemyCreator;

  static const enemy_speed = 400;
  List<GameObject> enemies = [];


  SpaceShooterGame(){
    player = GameObject()
        ..position = Rect.fromLTWH(200, 200, 100, 100);

    enemyCreator = Timer(1.0, repeat: true, callback: (){

      enemies.add(
        GameObject()
            ..position = Rect.fromLTWH(0, 0, 50, 50)

      );

    });
    enemyCreator.start();

  }

  void OnPlayerMove(Offset delta){

    player.position = player.position.translate(delta.dx, delta.dy);

  }

  
  @override
  void update(double dt){
    enemies.forEach((enemy) {

      enemy.position = enemy.position.translate(0, enemy_speed * dt);

    });

    enemyCreator.update(dt);
  }

  @override
  void render(Canvas canvas){
    
    player.render(canvas);

    enemies.forEach((enemy) {

      enemy.render(canvas);

    });

  }


}

