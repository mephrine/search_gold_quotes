import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/bloc/bloc.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:search_gold_quotes/core/presentation/routes/coordinator.gr.dart';

const String _SERVER_ERROR_MESSAGE = '일시적인 오류로 인하여 일부 가격만 표시됩니다.\n최신 가격을 보시려면 앱을 재실행해주세요.';
const String _BUTTON_CONFIRM_TITLE = '확인';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}

BlocProvider<SplashBloc> _buildBody(BuildContext context) {
  return BlocProvider(
    create: (_) => container<SplashBloc>(),
    child: SplashView()
  );
}

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              BlocBuilder<SplashBloc, SplashState>(builder: (_, state) {
                if (state is Empty) {
                  _dispatchVersion(context);
                }
                if (state is Loaded) {
                  _push(context, 2);
                } else if (state is Error) {
                  _showErrorAlert(context);
                }
                return Container(width: 0, height: 0);
              }),
              LottieGoldImageWidget(),
              LogoImageWidget()
            ],
          ),
        ),
      ),
    );
  }
}


class LottieGoldImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/gold.json',
      // width: 200,
      // height: 200,
      // fit: BoxFit.fill
      // controller: _controller,
      // onLoaded: (composition) {
        // Configure the AnimationController with the duration of the
        // Lottie file and start the animation.
        // _controller
        //   ..duration = composition.duration
        //   ..forward();
      // },
    );
  }
}

class LogoImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset('images/logo.png');
  }
}

void _dispatchVersion(BuildContext context) {
  SchedulerBinding.instance.addPostFrameCallback((_) => BlocProvider.of<SplashBloc>(context, listen: false)
      .add(GetVersionInfoForUpdate()));
}

void _push(BuildContext context, int delaySeconds) async {
  Timer(Duration(seconds: delaySeconds),
      () => ExtendedNavigator.of(context).replace(Routes.mainPage));
}

void _showErrorAlert(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        content: Text(_SERVER_ERROR_MESSAGE),
        actions: <Widget>[
          FlatButton(
            child: Text(_BUTTON_CONFIRM_TITLE),
            onPressed: () {
              _push(context, 0);
            },
          ),
        ],
      );
    },
  );
}

