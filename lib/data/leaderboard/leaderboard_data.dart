import 'dart:math';

import 'package:flutter/cupertino.dart';

class LeaderboardData extends Comparable {
  String name;
  int score;

  LeaderboardData({this.name, this.score});

  @override
  int compareTo(other) {
    return score.compareTo(other.score);
  }
}

class LeaderboardList {
  final _random = new Random();
  List<LeaderboardData> _list;

  LeaderboardList.createMockData() {
    _list = [
      _generateDataEntry("David", 30, 45),
      _generateDataEntry("Sarah", 35, 50),
      _generateDataEntry("Kim", 40, 55),
      _generateDataEntry("Kathie", 45, 60),
      _generateDataEntry("Carl", 50, 65),
      _generateDataEntry("Julie", 55, 70),
      _generateDataEntry("Steven", 60, 75),
      _generateDataEntry("Sam", 65, 80),
      _generateDataEntry("Jane", 70, 85),
      _generateDataEntry("Charlotte", 75, 95),
      _generateDataEntry("Rhian", 70, 85),
      _generateDataEntry("Harriet", 65, 80),
      _generateDataEntry("Jon", 60, 75),
      _generateDataEntry("Natalie", 55, 70),
      _generateDataEntry("Ryan", 10, 50),
    ];
    _list.sort((a,b) => b.compareTo(a));
  }

  List<LeaderboardData> getList(){
    return _list;
  }

  void addToList({@required name, @required score}){
    _list.add(LeaderboardData(name: name, score: score));
    _list.sort((a,b) => b.compareTo(a));
  }

  LeaderboardData _generateDataEntry(String name, int min, int max){
    return LeaderboardData(name: name, score: min + _random.nextInt(max - min));
  }
}
