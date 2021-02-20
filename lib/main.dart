import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/di/injection_container.dart' as di;
import 'core/presentation/routes/router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // 비동기로 진행 시, 반드시 추가해야함.
  await di.init();
  runApp(Main());
}

class Main extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
