import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaderboardTile extends StatelessWidget {
  final String name;
  final String score;
  final String rank;
  final Color color;

  LeaderboardTile(
      {@required this.rank,
      @required this.name,
      @required this.score,
      this.color = Colors.white
      });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        leading: Text(this.rank),
        title: Text(this.name),
        trailing: Text(this.score),
      ),
    );
  }
}

class LeaderboardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      child: ListTile(
        leading: Text("Rank"),
        title: Text("Name"),
        trailing: Text("Score"),
      ),
    );
  }
}
