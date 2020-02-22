import 'package:dissertation_project/pages/battery.dart';
import 'package:dissertation_project/pages/home_page.dart';
import 'package:dissertation_project/pages/leaderboard_page.dart';
import 'package:dissertation_project/pages/app_usage_page.dart';
import 'package:dissertation_project/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings routeSettings){
    switch (routeSettings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => HomePage());
      case LEADERBOARD:
        return MaterialPageRoute(builder: (_) => LeaderboardPage());
      case APPUSAGE:
        return MaterialPageRoute(builder: (_) => AppUsagePage());
      case BATTERY:
        return MaterialPageRoute(builder: (_) => BatteryPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${routeSettings.name}')),
            ));
    }
  }
}
