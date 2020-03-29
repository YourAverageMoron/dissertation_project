import 'package:dissertation_project/data/leaderboard/leaderboard_data.dart';
import 'package:dissertation_project/widgets/leaderboard_tile.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  List<LeaderboardData> items = LeaderboardList.createMockData().getList().sublist(0, 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboard"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          LeaderboardHeader(),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return LeaderboardTile(
                name: items[index].name,
                score: items[index].score.toString(),
                rank: "${index+1}",
              );
            },
          ),
        ],
      ),
    );
  }
}
