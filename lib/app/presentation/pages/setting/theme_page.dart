import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/app/presentation/widgets/navigation_push_widget.dart';
import 'package:search_gold_quotes/app/presentation/widgets/separator_widget.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:search_gold_quotes/core/values/dimens.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

ThemeNotifier themeService;

class ThemePage extends StatelessWidget {
  final String title;

  ThemePage({@required this.title});

  @override
  Widget build(BuildContext context) {
    themeService = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeService.getTheme(),
      home: _ThemeView(title: title),
    );
  }
}

class _ThemeView extends StatefulWidget {
  final String title;

  _ThemeView({@required this.title});

  @override
  _ThemeViewState createState() => _ThemeViewState();
}

class _ThemeViewState extends State<_ThemeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavigationPushWidget(title: widget.title),
      body: ListView(
        children: [
          _ListItemWidget(
              title: Strings.titleThemeLight, routeAction: () {}, index: 0),
          SeparatorWidget(),
          _ListItemWidget(
              title: Strings.titleThemeDark, routeAction: () {}, index: 1),
          SeparatorWidget(),
          _ListItemWidget(
              title: Strings.titleThemeSystem, routeAction: () {}, index: 2),
        ],
        padding: EdgeInsets.fromLTRB(
            Dimens.margin, Dimens.spacing, Dimens.margin, Dimens.spacing),
      ),
    );
  }
}

class _ListItemWidget extends StatefulWidget {
  final String title;
  final Function routeAction;
  final int index;

  _ListItemWidget(
      {Key key,
      @required this.title,
      @required this.routeAction,
      @required this.index})
      : super(key: key);

  @override
  __ListItemWidgetState createState() => __ListItemWidgetState();
}

class __ListItemWidgetState extends State<_ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.routeAction(),
        child: Container(
          height: 68,
          child: Row(
            children: [
              Text(
                widget.title,
                style: TextPrimaryContrastingStyles.bigStyle(context),
              ),
              const Spacer(),
              Radio(
                value: widget.index,
                groupValue: themeService.getThemeMode().modeValue(),
                activeColor: Theme.of(context).accentColor,
                onChanged:
                    widget.index == themeService.getThemeMode().modeValue()
                        ? null
                        : (int value) {
                            setState(() {
                              switch (value) {
                                case 0:
                                  themeService.setLightMode();
                                  break;
                                case 1:
                                  themeService.setDarkMode();
                                  break;
                                case 2:
                                  themeService.setSystemMode();
                                  break;
                              }
                            });
                          },
              ),
            ],
          ),
        ));
  }
}
