import 'package:dissertation_project/bloc/score/score_bloc.dart';
import 'package:dissertation_project/bloc/score/score_event.dart';
import 'package:dissertation_project/bloc/score/score_state.dart';
import 'package:dissertation_project/widgets/drawer.dart';
import 'package:dissertation_project/widgets/flower/tracking_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: BlocBuilder<ScoreBloc, ScoreState>(
          builder: (context, state) {
            if(state is ScoreEmpty){
              BlocProvider.of<ScoreBloc>(context)
                  .add(FetchScore(date:DateTime.now()));
              return Center(child: Text('Empty'));
            }
            if(state is ScoreLoaded){
              return Center(child: TrackingInput());
            }
            if(state is ScoreLoading){
              return Center(child: Text('loading'));
            }
            if(state is ScoreError){
              return Center(child: Text('error'));
            }
            return null;
          },
        ),
      ),
    );
  }
}
