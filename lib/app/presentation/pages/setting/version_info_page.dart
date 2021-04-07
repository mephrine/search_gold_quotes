import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/app/presentation/widgets/logo_image_widget.dart';
import 'package:search_gold_quotes/app/presentation/widgets/lottie_gold_image_widget.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/core/platform/device_utils.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';

class VersionInfoPage extends StatelessWidget {
  final String title;

  VersionInfoPage({@required this.title});

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeService.getTheme(),
      home: _VersionInfoView(title: title),
    );
  }
}

class _VersionInfoView extends StatefulWidget {
  final String title;

  _VersionInfoView({@required this.title});

  @override
  _VersionInfoViewState createState() => _VersionInfoViewState();
}

class _VersionInfoViewState extends State<_VersionInfoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavigationPushWidget(title: widget.title),
        body: ChangeNotifierProvider(
            create: (context) => PackageVersionInfoProvider(),
            child: Builder(
              builder: (context) {
                var versionInfoProvider =
                    Provider.of<PackageVersionInfoProvider>(context);
                versionInfoProvider.loadVersionInfo();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieGoldImageWidget(onLoaded: () => null),
                    LogoImageWidget(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        '현재 버전 : ${versionInfoProvider.getVersionInfo()}',
                        textAlign: TextAlign.center,
                        style: TextPrimaryContrastingStyles.bigStyle(context),
                      ),
                    )
                  ],
                );
              },
            )));
  }
}

class PackageVersionInfoProvider extends ChangeNotifier {
  String _versionInfo = "";

  String getVersionInfo() => _versionInfo;

  loadVersionInfo() async {
    _versionInfo = await DeviceUtils.version;
    notifyListeners();
  }
}
