import 'package:dissertation_project/bloc/statistics/statistics_bloc.dart';
import 'package:dissertation_project/bloc/statistics/statistics_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeuristicStat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(builder: (context, state) {
      if(state is StatsLoaded){
        return Text( state.heuristicString,
          style: Theme.of(context).textTheme.headline2,
          overflow: TextOverflow.ellipsis,
        );
      }
      return Text("Please wait while the statistics load",
          style: Theme.of(context).textTheme.headline2,
      );

    });
  }
}
