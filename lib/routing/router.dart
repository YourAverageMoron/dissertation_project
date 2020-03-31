import 'package:dissertation_project/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:dissertation_project/bloc/score/score_bloc.dart';
import 'package:dissertation_project/bloc/settings/scaled_application/scaled_application_bloc.dart';
import 'package:dissertation_project/bloc/statistics/statistics_bloc.dart';
import 'package:dissertation_project/pages/app_usage_page.dart';
import 'package:dissertation_project/pages/home_page.dart';
import 'package:dissertation_project/pages/leaderboard_page.dart';
import 'package:dissertation_project/pages/settings_page.dart';
import 'package:dissertation_project/pages/statistic_page.dart';
import 'package:dissertation_project/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HOME:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => ScoreBloc(), child: HomePage()));
      case LEADERBOARD:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => LeaderboardBloc(),
                child: LeaderboardPage()));
      case APPUSAGE:
        return MaterialPageRoute(builder: (_) => AppUsagePage());
      case STATISTICS:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => StatsBloc(), child: StatisticsPage()));
      case SETTINGS:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => ScaledApplicationBloc(),
                child: SettingsPage()));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child:
                          Text('No route defined for ${routeSettings.name}')),
                ));
    }
  }
}
