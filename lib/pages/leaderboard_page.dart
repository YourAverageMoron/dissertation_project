import 'package:dissertation_project/widgets/leaderboard_tile.dart';
import 'package:flutter/material.dart';

List<String> items = List<String>.generate(5, (i) => "Item $i");

class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboard"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return LeaderboardTile(
            name: items[index],
            value: "$index",
          );
        },
      ),
    );
  }
}