import 'package:dissertation_project/bloc/settings/scaled_application/scaled_application_bloc.dart';
import 'package:dissertation_project/bloc/settings/scaled_application/scaled_application_event.dart';
import 'package:dissertation_project/bloc/settings/scaled_application/scaled_application_state.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO COULD MAKE THIS GENERIC?
//PASS IN TEXT AND INSIDE WIDGET?
class ScaledApplicationEditorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text('Applications that scale your score'),
          children: <Widget>[
            DropdownContent(),
          ],
        ),
      ),
    );
  }
}

ScaledApp testScaledApp = ScaledApp(
    appName: "app", scaleFactor: 0.4, packageName: "package", icon: null);

class DropdownContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScaledApplicationBloc, ScaledApplicationState>(
        builder: (context, state) {

      if(state is ScaledApplicationFormState){
        return ScaledApplicationForm(scaledApp: state.scaledApp);
      }
      if (state is ScaledApplicationsLoaded) {
        List<ScaledApp> listApps = [];
        state.scaledApps.forEach((key, value) => listApps.add(value));
        return Column(
          children: <Widget>[
            ListView.builder(
                itemCount: state.scaledApps.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return EditScaledApplicationCard(scaledApp: listApps[index]);
                }),
            RaisedButton(
              child: Text("Add a new scaled application"),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () => BlocProvider.of<ScaledApplicationBloc>(context)
                  .add(AddScaledApp(
                      testScaledApp)), // todo this needs to create a popup instead
            ),
          ],
        );
      }
      BlocProvider.of<ScaledApplicationBloc>(context).add(LoadScaledApp());
      return Text("Please wait"); //TODO I MIGHT WANT A WAITING THING HERE
    });
  }
}

class EditScaledApplicationCard extends StatelessWidget {
  final ScaledApp scaledApp;

  EditScaledApplicationCard({@required this.scaledApp});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScaledApplicationBloc, ScaledApplicationState>(
        builder: (context, state) {
      return Card(
          child: ListTile(
        onTap: () => BlocProvider.of<ScaledApplicationBloc>(context)
            .add(ScaledAppFormEvent(scaledApp)),
        leading: Icon(Icons.apps),
        title: Text(scaledApp.getAppName()),
        subtitle: Text(scaledApp.getScaleFactor().toString()),
        trailing: IconButton(
          icon: Icon(Icons.remove),
          color: Colors.red,
          onPressed: () {
            BlocProvider.of<ScaledApplicationBloc>(context)
                .add(DeleteScaledApp(scaledApp));
          },
        ),
      ));
    });
  }
}


//TODO THIS IS WRONG
// Use https://bloclibrary.dev/#/flutterlogintutorial?id=login-form
class ScaledApplicationForm extends StatelessWidget {
  final ScaledApp scaledApp;

  ScaledApplicationForm({@required this.scaledApp});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScaledApplicationBloc, ScaledApplicationState>(
        builder: (context, state) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              readOnly: true,
              controller: TextEditingController(text: scaledApp.getAppName()),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Application Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Scale factor',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              RaisedButton(
                child: Text('Cancel'),
                textColor: Colors.white,
                color: Colors.grey,
                onPressed: () {  },),
              Spacer(),
              RaisedButton(
                child: Text('Update'),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  //ScaledApp newScaledApp = ScaledApp(); //TODO WORK OUT HOW TO CREATE THE SCALED APP
                  BlocProvider.of<ScaledApplicationBloc>(context)
                    .add(AddScaledApp(testScaledApp));}),
              Spacer(),
            ],
          )
        ],
      );
    });
  }
}
