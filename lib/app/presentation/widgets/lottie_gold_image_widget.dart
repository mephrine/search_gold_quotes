import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieGoldImageWidget extends StatefulWidget {
  final Function onLoaded;
  const LottieGoldImageWidget({Key key, @required this.onLoaded})
      : super(key: key);

  @override
  _LottieGoldImageWidgetState createState() => _LottieGoldImageWidgetState();
}

class _LottieGoldImageWidgetState extends State<LottieGoldImageWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/gold.json',
        height: 200,
        controller: _controller,
        onLoaded: (composition) => {
              _controller
                ..duration = composition.duration
                ..forward(),
              Future.delayed(Duration(seconds: 2), () => widget.onLoaded()),
            });
  }
}
