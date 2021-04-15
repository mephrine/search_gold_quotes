import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/bloc/bloc.dart';
import 'package:search_gold_quotes/app/presentation/widgets/logo_image_widget.dart';
import 'package:search_gold_quotes/app/presentation/widgets/lottie_gold_image_widget.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';
import 'package:auto_route/auto_route.dart';
import 'package:search_gold_quotes/core/platform/device_utils.dart';
import 'package:search_gold_quotes/core/presentation/routes/router.gr.dart';
import 'package:search_gold_quotes/core/values/constants.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(builder: (context, state) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieGoldImageWidget(onLoaded: () async => _dispatchVersion(context)),
              LogoImageWidget(),
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is Loaded) {
        if (state.needsForceUpdate) {
          _showVersionUpdateAlert(state.updateMessage);
        } else {
          _pushToMainPage(2);
        }
      } else if (state is Error) {
        _showErrorAlert();
      }
    });
  }

  void _dispatchVersion(BuildContext context) async {
    context.read<SplashBloc>().add(GetVersionInfoForUpdate());
  }

  void _showErrorAlert() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Text(_SERVER_ERROR_MESSAGE),
          actions: <Widget>[
            MaterialButton(
                child: Text(_BUTTON_CONFIRM_TITLE),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _pushToMainPage(0);
                }),
          ],
        );
      },
    );
  }

  void _showVersionUpdateAlert(String updateMessage) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Text(updateMessage),
          actions: <Widget>[
            MaterialButton(
                child: Text(_BUTTON_CONFIRM_TITLE),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _moveToAppStore();
                }),
          ],
        );
      },
    );
  }

  void _moveToAppStore() async {
    String storeLink;
    if (DeviceUtils.isAndroid) {
      final packageName = await DeviceUtils.packageName;
      storeLink = Constants.playStoreLink + packageName;
    } else {
      storeLink = Constants.appStoreLink;
    }
    await launch(storeLink, forceWebView: false, forceSafariVC: false);
  }

  void _pushToMainPage(int delaySeconds) async {
    // Timer(
    //     Duration(seconds: delaySeconds),
    context.rootNavigator
        .pushAndRemoveUntil(AppRoute.mainPage, (route) => false);
    // context.rootNavigator.pushAndRemoveUntil(AppRoute.mainPage,
    //     predicate: (routes) {
    //   return false;
    // }, onFailure: (routes) {});
  }
}
