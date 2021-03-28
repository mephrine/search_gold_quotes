import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieGoldImageWidget extends StatelessWidget {
  final Function onLoaded;

  const LottieGoldImageWidget({Key key, @required this.onLoaded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/gold.json',
        height: 200,
        // controller: _controller,
        onLoaded: (_) => onLoaded()
        // Configure the AnimationController with the duration of the
        // Lottie file and start the animation.
        // _controller
        //   ..duration = composition.duration
        //   ..forward();
        // },
        );
  }
}
