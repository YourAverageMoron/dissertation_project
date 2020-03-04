import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'animation_controls.dart';

class TrackingInput extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TrackingState();
}

class TrackingState extends State<TrackingInput>{

  AnimationControls _animationControls;
  final FlareControls flowerMoveControls = FlareControls();
  int currentScore = 0;
  int maxScore = 0;
  
  @override
  void initState(){
    _animationControls = AnimationControls();
    super.initState();
  }

  void incrementScore(){
    currentScore ++;

    _animationControls.updateScore(currentScore.toDouble());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FlareActor('assets/Flower.flr',
              controller: _animationControls,
              fit: BoxFit.contain,
              animation: 'Ruffle flowers',
              artboard: 'Artboard',
            ),

          ],
        )
      ),
    );
  }
}