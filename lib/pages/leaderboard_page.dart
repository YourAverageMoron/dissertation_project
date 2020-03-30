import 'package:dissertation_project/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:dissertation_project/bloc/leaderboard/leaderboard_event.dart';
import 'package:dissertation_project/bloc/leaderboard/leaderboard_state.dart';
import 'package:dissertation_project/data/leaderboard/leaderboard_data.dart';
import 'package:dissertation_project/widgets/leaderboard_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderboardPage extends StatelessWidget {
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
          BlocBuilder<LeaderboardBloc, LeaderboardState>(
              builder: (context, state) {
            if (state is LeaderboardEmpty) {
              BlocProvider.of<LeaderboardBloc>(context)
                  .add(FetchLeaderboard(date: DateTime.now()));
            }
            if (state is LeaderboardLoading) {
              return Text("Loading");
            }
            if (state is LeaderboardLoaded) {
              return LoadedLeaderboard(leaderboardRows: state.leaderboardRows);
            }
            return Text("errors");
          }),
        ],
      ),
    );
  }
}

class LoadedLeaderboard extends StatelessWidget {
  List<RankedLeaderboardData> leaderboardRows;

  LoadedLeaderboard({this.leaderboardRows});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: leaderboardRows.length,
      itemBuilder: (context, index) {
        if(leaderboardRows[index].name == "You"){
          return LeaderboardTile(
            name: leaderboardRows[index].name,
            score: leaderboardRows[index].score.toString(),
            rank: (leaderboardRows[index].rank + 1).toString(),
            color: Colors.teal[100],
          );
        }
        return LeaderboardTile(
          name: leaderboardRows[index].name,
          score: leaderboardRows[index].score.toString(),
          rank: (leaderboardRows[index].rank + 1).toString(),
        );
      },
    );
  }
}
