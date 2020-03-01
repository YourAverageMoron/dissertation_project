import 'package:dissertation_project/data/score/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class AppUsagePage extends StatefulWidget {
  AppUsagePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppUsagePageState createState() => _AppUsagePageState();
}

class _AppUsagePageState extends State<AppUsagePage> {
  static const platform =
  const MethodChannel('uk.ac.bath.dissertation_project/helper_methods');

  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    kiwi.Container container = kiwi.Container();
    Score score = container<Score>();
    score.generateScore(DateTime.now());

    String batteryLevel;
    try {
      int endTime = DateTime.now().millisecondsSinceEpoch;
      int startTime = endTime - 300000;
      var result = await platform.invokeMethod('getUsageStats',{'startTime': startTime, 'endTime':endTime});
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Battery"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton(
              child: Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
