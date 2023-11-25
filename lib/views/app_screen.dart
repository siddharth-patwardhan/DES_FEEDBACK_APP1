import 'package:des_feedback_app/app_theme.dart';
import 'package:des_feedback_app/app_theme_notifier.dart';
import 'package:des_feedback_app/utils/size_config.dart';
import 'package:des_feedback_app/views/home_screen.dart';
import 'package:des_feedback_app/views/setting_screen.dart';
import 'package:des_feedback_app/views/auth/register_screen.dart';
import 'package:des_feedback_app/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class AppScreen extends StatefulWidget {
  final int selectedPage;

  const AppScreen({Key key, this.selectedPage = 0}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  TabController _tabController;

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);

    super.initState();
  }

  dispose() {
    super.dispose();
    _tabController.dispose();
  }

  ThemeData themeData;
  CustomAppTheme customAppTheme;

  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (BuildContext context, AppThemeNotifier value, Widget child) {
        int themeMode = value.themeMode();
        themeData = AppTheme.getThemeFromThemeMode(themeMode);
        customAppTheme = AppTheme.getCustomAppTheme(themeMode);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getThemeFromThemeMode(value.themeMode()),
          home: Scaffold(
            backgroundColor: customAppTheme.bgLayer1,
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                LoginScreen(),
                HomeScreen(),
                RegisterScreen(),
                SettingScreen()
              ],
            ),
          ),
        );
      },
    );
  }
}
