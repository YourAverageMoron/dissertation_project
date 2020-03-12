import 'package:dissertation_project/bloc/score/score_bloc.dart';
import 'package:dissertation_project/bloc/score/score_state.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'animation_controls.dart';

class TrackingInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TrackingState();
}

class TrackingState extends State<TrackingInput> {
  final FlareControls flowerMoveControls = FlareControls();
  double currentScore = 0;

  @override
  void initState() {
    super.initState();
  }

  //THIS EXTENDS SCORE
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
      if(state is ScoreLoading){
        return FlowerContainer(state.animationControls);
      }
      if(state is ScoreLoaded){
       // print(state.animationControls.)
        return FlowerContainer(state.animationControls);
      }
      return Text("This state should never happen");
    });
  }
}

class FlowerContainer extends StatelessWidget {

  final AnimationControls animationControls;

  FlowerContainer(this.animationControls);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              FlareActor(
                'assets/Flower.flr',
                controller: animationControls,
                fit: BoxFit.contain,
                animation: 'Ruffle flowers',
                artboard: 'Artboard',
              ),
            ],
          )),
    );
  }

}
