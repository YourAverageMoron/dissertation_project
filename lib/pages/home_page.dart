import 'package:dissertation_project/bloc/score/score_bloc.dart';
import 'package:dissertation_project/bloc/score/score_event.dart';
import 'package:dissertation_project/bloc/score/score_state.dart';
import 'package:dissertation_project/routing/routes.dart';
import 'package:dissertation_project/widgets/drawer.dart';
import 'package:dissertation_project/widgets/flower/tracking_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {

  void _scoreInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Score Info"),
          content: new Text('''Your score is calculated using:
- The amount of screen time
- Amount of applications opened
- These are scaled based on which application the time of day (these can be changed in the settings page)'''),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
            if (state is ScoreEmpty) {
              BlocProvider.of<ScoreBloc>(context)
                  .add(FetchScore(date: DateTime.now()));
              return Center(child: Text('Empty'));
            }
            if (state is ScoreLoaded) {
              return Center(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Center(
                            child: RaisedButton(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              onPressed: () {_scoreInfoDialog(context);},
                              child: Column(children: [
                                Text(
                                  'Your Score',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  '${state.score}/100',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                )
                              ]),
                            )),
                      ),
                      Container(height: 400, child: TrackingInput()),
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
                        child: RaisedButton(
                            textColor: Colors.white,
                            color: Theme
                                .of(context)
                                .primaryColor,
                            child: Text('View your phone usage stats'),
                            onPressed: () {
                              Navigator.pushNamed(context, STATISTICS);
                            }),
                      )
                    ],
                  ));
            }
            if (state is ScoreLoading) {
              return Center(child: Text('loading'));
            }
            if (state is ScoreError) {
              return Center(child: Text('error'));
            }
            return null;
          },
        ),
      ),
    );
  }
}

