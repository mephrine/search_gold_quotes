import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/bloc/bloc.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:auto_route/auto_route.dart';
import 'package:search_gold_quotes/core/presentation/routes/router.gr.dart';

const String _SERVER_ERROR_MESSAGE =
    '일시적인 오류가 발생했습니다.\n최신 가격을 보시려면 앱을 재실행해주세요.';
const String _BUTTON_CONFIRM_TITLE = '확인';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => container<SplashBloc>(), child: SplashView());
  }
}

class SplashView extends StatefulWidget {
  @override
  _SplashView createState() => _SplashView();
}

class _SplashView extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _dispatchVersion(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(builder: (context, state) {
      return CupertinoPageScaffold(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieGoldImageWidget(),
                LogoImageWidget()
              ],
            ),
          ),
        );
    }, listener: (context, state) {
      if (state is Loaded) {
        _push(2);
      } else if (state is Error) {
        _showErrorAlert();
      }
    });
  }

  void _showErrorAlert() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text(_SERVER_ERROR_MESSAGE),
          actions: <Widget>[
            CupertinoButton(
              child: Text(_BUTTON_CONFIRM_TITLE),
              onPressed: () {
                _push(0);
              },
            ),
          ],
        );
      },
    );
  }

  void _push(int delaySeconds) async {
    Timer(
        Duration(seconds: delaySeconds),
        () => context.router.pushAndRemoveUntil(MainPage(),
            predicate: (routes) {
             return false;
            }, onFailure: (routes) {}));
  }
}

class LottieGoldImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/gold.json',
        height: 200,

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
    return Image.asset(
        'images/logo.png',
      width: 50,
      height: 25,
    );
  }
}

void _dispatchVersion(BuildContext context) {
  SchedulerBinding.instance.addPostFrameCallback((_) =>
      BlocProvider.of<SplashBloc>(context, listen: false)
          .add(GetVersionInfoForUpdate()));
}
