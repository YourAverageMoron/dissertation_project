package uk.ac.bath.dissertation_project;

import android.annotation.TargetApi;
import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.drawable.Drawable;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


//TODO Find a way to pull some of the logic out of here and into other activity classes
public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "uk.ac.bath.dissertation_project/helper_methods";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getBatteryLevel")) {
                                handleGetBatteryLevel(result);
                            }
                            if (call.method.equals("getUsageStats")) {
                                long currTime = System.currentTimeMillis();
                                long startTime = currTime - 3000000;
                                getUsageStats(startTime, currTime);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    // Battery methods
    private void handleGetBatteryLevel(MethodChannel.Result result) {
        int batteryLevel = getBatteryLevel();

        if (batteryLevel != -1) {
            result.success(batteryLevel);
        } else {
            result.error("UNAVAILABLE", "Battery level not available.", null);
        }
    }

    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }
        return batteryLevel;
    }

    //Usage methods
    // You might have to change the version of the API somewhere
    @TargetApi(VERSION_CODES.N)
    private void getUsageStats(Long startTime, Long endTime) {
        UsageEvents.Event currentEvent;
        List<UsageEvents.Event> allEvents = new ArrayList<>();
        HashMap<String, AppUsageInfo> map = new HashMap<String, AppUsageInfo>();

        long phoneUsageToday = 0;

        Context context = this.getContext();
        UsageStatsManager usageStatsManager = (UsageStatsManager) context.getSystemService(Context.USAGE_STATS_SERVICE);
        assert usageStatsManager != null;

        UsageEvents usageEvents = usageStatsManager.queryEvents(startTime, endTime);

        while (usageEvents.hasNextEvent()) {
            currentEvent = new UsageEvents.Event();
            usageEvents.getNextEvent(currentEvent);
            if (currentEvent.getEventType() == UsageEvents.Event.MOVE_TO_FOREGROUND ||
                    currentEvent.getEventType() == UsageEvents.Event.MOVE_TO_BACKGROUND) {
                allEvents.add(currentEvent);
                String key = currentEvent.getPackageName();
// taking it into a collection to access by package name
                if (map.get(key) == null)
                    map.put(key, new AppUsageInfo(key));
            }
        }

//iterating through the arraylist
        for (int i = 0; i < allEvents.size() - 1; i++) {
            UsageEvents.Event E0 = allEvents.get(i);
            UsageEvents.Event E1 = allEvents.get(i + 1);

//for launchCount of apps in time range
            if (!E0.getPackageName().equals(E1.getPackageName()) && E1.getEventType() == 1) {
// if true, E1 (launch event of an app) app launched
                map.get(E1.getPackageName()).launchCount++;
            }

//for UsageTime of apps in time range
            if (E0.getEventType() == 1 && E1.getEventType() == 2
                    && E0.getClassName().equals(E1.getClassName())) {
                long diff = E1.getTimeStamp() - E0.getTimeStamp();
                phoneUsageToday += diff; //gloabl Long var for total usagetime in the timerange
                map.get(E0.getPackageName()).timeInForeground += diff;
            }
        }
        map.values().forEach((val) -> System.out.println(val.packageName + " " + val.timeInForeground));
    }
}


class AppUsageInfo {
    Drawable appIcon;
    String appName, packageName;
    long timeInForeground;
    int launchCount;

    AppUsageInfo(String pName) {
        this.packageName=pName;
    }
}