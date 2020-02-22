import 'package:app_usage/app_usage.dart';

//TODO USE https://pub.dev/packages/flutter_package_manager TO GET NAMES OF APPS
class AppUsageTime{

  Future<Map<String, double>> getUsageStats(DateTime startDate, DateTime endDate) async {
    // Initialization
    AppUsage appUsage = new AppUsage();
    try {
      // Define a time interval

      // Fetch the usage stats
      Map<String, double> usage = await appUsage.fetchUsage(startDate, endDate);

      // (Optional) Remove entries for apps with 0 usage time
      usage.removeWhere((key,val) => val == 0);

      return usage;
    }
    on AppUsageException catch (exception) {
      print(exception);
      return null; //TODO CHECK THIS IF THERE IS A BETTER THING TO RETURN
    }
  }
}