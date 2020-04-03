import 'package:dissertation_project/bloc/settings/scaled_application/add_scaled_app_form_bloc.dart';
import 'package:dissertation_project/bloc/settings/scaled_application/scaled_app_list_bloc.dart';
import 'package:dissertation_project/data/app_scaler/scaled_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

//TODO COULD MAKE THIS GENERIC?
//PASS IN TEXT AND INSIDE WIDGET?
class ScaledApplicationEditorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text('Your "bad" applications'),
          children: <Widget>[
            DropdownContent(),
          ],
        ),
      ),
    );
  }
}

class DropdownContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddScaledAppFormBloc>(
          create: (context) => AddScaledAppFormBloc(),
        ),
        BlocProvider<ScaledAppListBloc>(
          create: (context) => ScaledAppListBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        // ignore: close_sinks
        final AddScaledAppFormBloc addScaledAppFormBloc =
            context.bloc<AddScaledAppFormBloc>();
        // ignore: close_sinks
        final ScaledAppListBloc scaledAppListBloc =
            context.bloc<ScaledAppListBloc>();
        return Column(
          children: <Widget>[
            AddScaledAppForm(addScaledAppFormBloc, scaledAppListBloc),
            SelectedScaledApps(scaledAppListBloc, addScaledAppFormBloc),
          ],
        );
      }),
    );
  }
}

class SelectedScaledApps extends StatelessWidget {
  final ScaledAppListBloc scaledAppListBloc;
  final AddScaledAppFormBloc addScaledAppFormBloc;

  SelectedScaledApps(this.scaledAppListBloc, this.addScaledAppFormBloc);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<ScaledAppListBloc, List<ScaledApp>>(
        builder: (context, state) {
      return ListView.builder(
          itemCount: state.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _ScaledApplicationCard(
              scaledApp: state[index],
              addScaledAppFormBloc: addScaledAppFormBloc,
              scaledAppListBloc: scaledAppListBloc,
            );
          });
    });
  }
}

class _ScaledApplicationCard extends StatelessWidget {
  final ScaledApp scaledApp;
  final AddScaledAppFormBloc addScaledAppFormBloc;
  final ScaledAppListBloc scaledAppListBloc;

  _ScaledApplicationCard(
      {this.scaledApp, this.addScaledAppFormBloc, this.scaledAppListBloc});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: scaledApp.getIcon(),
      title: Text(scaledApp.getAppName()),
      subtitle: Text(scaledApp.getScaleFactor().toString()),
      trailing: IconButton(
        icon: Icon(Icons.remove),
        color: Colors.red,
        onPressed: () {
          Function.apply(addScaledAppFormBloc.removeScaledApp,
              [scaledAppListBloc, scaledApp]);
        },
      ),
    ));
  }
}

class AddScaledAppForm extends StatelessWidget {
  final AddScaledAppFormBloc addScaledAppFormBloc;
  final ScaledAppListBloc scaledAppListBloc;

  AddScaledAppForm(this.addScaledAppFormBloc, this.scaledAppListBloc);

  @override
  Widget build(BuildContext context) {
    return FormBlocListener<AddScaledAppFormBloc, String, String>(
        child: Row(children: <Widget>[
      Expanded(
          child: TextFieldBlocBuilder(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.apps),
          labelText: "some",
        ),
        textFieldBloc: addScaledAppFormBloc.textField,
      )),
      IconButton(
        color: Colors.green,
        onPressed: () => Function.apply(
            addScaledAppFormBloc.addScaledApp, [scaledAppListBloc, 2.0]),
        icon: Icon(Icons.add_circle),
      )
    ]));
  }
}
