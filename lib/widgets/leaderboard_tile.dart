import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaderboardTile extends StatelessWidget {
  final String name;
  final String score;
  final String rank;

  LeaderboardTile(
      {@required this.rank,
      @required this.name,
      @required this.score});
  @override
  Widget build(BuildContext context) {
    return Card(
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
