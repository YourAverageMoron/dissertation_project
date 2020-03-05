import 'dart:math';

import 'package:flare_dart/math/mat2d.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';

class AnimationControls extends FlareController {
  ActorAnimation _sadToHappyAnimation;
  ActorAnimation _ruffleFlower;

  double _score = 0;
  double _currentScore = 0;

  double _smoothTime = 5;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    if (artboard.name.compareTo('Artboard') == 0) {
      {
        _currentScore +=
            (_score - _currentScore) * min(1, elapsed * _smoothTime);
        _sadToHappyAnimation.apply(
            _currentScore * _sadToHappyAnimation.duration, artboard, 1);
      }
    }
    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    if (artboard.name.compareTo('Artboard') == 0) {
      _sadToHappyAnimation = artboard.getAnimation('Sad to happy');
      _ruffleFlower = artboard.getAnimation('Ruffle flowers');
    }
  }

  @override
  void setViewTransform(Mat2D viewTransform) {
    // TODO: implement setViewTransform
  }

  void updateScore(double newScore) {
    _score = newScore;
  }

  void resetScore() {
    _score = 0;
  }
}
