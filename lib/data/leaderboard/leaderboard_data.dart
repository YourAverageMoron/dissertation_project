import 'dart:math';

import 'package:flutter/cupertino.dart';

class LeaderboardData extends Comparable{
  String name;
  int score;

  LeaderboardData({this.name, this.score});

  @override
  int compareTo(other) {
    return score.compareTo(other.score);
  }
}

class RankedLeaderboardData extends LeaderboardData {
  String name;
  int score;
  int rank;

  RankedLeaderboardData({this.name, this.score, this.rank});

  RankedLeaderboardData.fromLeaderboardData(LeaderboardData data, int rank) {
    this.name = data.name;
    this.score = data.score;
    this.rank = rank;
  }
}

class LeaderboardEntries {
  final _random = new Random();
  Map<String, LeaderboardData> _entries;

  LeaderboardEntries.createMockData() {
    _entries = {
      "David": _generateDataEntry("David", 30, 45),
      "Sarah": _generateDataEntry("Sarah", 35, 50),
      "Alix": _generateDataEntry("Alix", 40, 55),
      "Kathie": _generateDataEntry("Kathie", 45, 60),
      "Carl": _generateDataEntry("Carl", 50, 65),
      "Julie": _generateDataEntry("Julie", 55, 70),
      "Steven": _generateDataEntry("Steven", 60, 75),
      "Sam": _generateDataEntry("Sam", 65, 80),
      "Jane": _generateDataEntry("Jane", 70, 85),
      "Charlotte": _generateDataEntry("Charlotte", 75, 95),
      "Rhian": _generateDataEntry("Rhian", 70, 85),
      "Harriet": _generateDataEntry("Harriet", 65, 80),
      "Jon": _generateDataEntry("Jon", 60, 75),
      "Natalie": _generateDataEntry("Natalie", 55, 70),
      "Ryan": _generateDataEntry("Ryan", 10, 50),
    };
  }

  List<RankedLeaderboardData> getOrderedList() {
    List<LeaderboardData> entryList = _entries.values.toList();

    entryList.sort((a, b) => b.compareTo(a));


    List<RankedLeaderboardData> rankedEntryList = [];

    for (int i = 0 ; i < entryList.length; i++) {
      rankedEntryList
          .add(RankedLeaderboardData.fromLeaderboardData(entryList[i], i));
    }

    return rankedEntryList;
  }

  void addToList({@required String name, @required LeaderboardData entry}) {
    _entries[name] = entry;
  }

  LeaderboardData _generateDataEntry(String name, int min, int max) {
    return LeaderboardData(name: name, score: min + _random.nextInt(max - min));
  }
}
