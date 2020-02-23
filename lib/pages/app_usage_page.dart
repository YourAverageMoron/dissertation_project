import 'package:dissertation_project/data/phone_usage/app_usage_time.dart';
import 'package:dissertation_project/data/score/score.dart';
import 'package:flutter/material.dart';

// TODO THIS IS A GOOD EXAMPLE OF HOW TO USE THE FUTURE BUILDER
class AppUsagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppUsagePageState();
  }
}

class AppUsagePageState extends State<AppUsagePage> {
  Future appUsageFuture;

  AppUsageTime appUsageTime = AppUsageTime();

  @override
  void initState() {
    super.initState();
    appUsageFuture = _getAppUsage();
  }

  _getAppUsage() async {
    //TODO REMOVE THIS LATER (JUST TESTING SCORE OBJECT)
    Score score = Score();
    await score.generateScore(DateTime.now());

    DateTime endDate = new DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);
    return await appUsageTime.getUsageStats(startDate, endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Usage"),
      ),
      body: Center(
        child: FutureBuilder(
          future: appUsageFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("None");
              case ConnectionState.waiting:
                return Text("Waiting");
              case ConnectionState.active:
                return Text("Active");
              case ConnectionState.done:
                return Text(snapshot.data.toString());
              default:
                return Text("Default");
            }
          },
        ),
      ),
    );
  }
}
