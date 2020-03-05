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
  double currentScore = 0;
  
  @override
  void initState(){
    _animationControls = AnimationControls();
    super.initState();
  }

  void setScore(double score){
    currentScore  = score; // TODO do we need to save this -> just in case we do some manipulation later
    print(currentScore);
    _animationControls.updateScore(currentScore);
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Slider(
                  min:0,
                  max: 1,
                  divisions: 100,
                  value: currentScore,
                  onChanged: (double newValue) {
                    setState(() {
                      currentScore = newValue;
                    });
                    setScore(currentScore);
                  },
                  
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}