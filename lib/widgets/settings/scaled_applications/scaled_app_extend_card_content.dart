import 'package:dissertation_project/bloc/settings/scaled_application/add_scaled_app_form_bloc.dart';
import 'package:dissertation_project/widgets/settings/scaled_applications/scaled_app_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_scaled_app_field.dart';

class ScaledAppExtendCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddScaledAppFormBloc>(
          create: (context) => AddScaledAppFormBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        // ignore: close_sinks
        final AddScaledAppFormBloc addScaledAppFormBloc =
        context.bloc<AddScaledAppFormBloc>();
        return Column(
          children: <Widget>[
            AddScaledAppField(bloc: addScaledAppFormBloc),
            SelectedScaledAppsList(bloc: addScaledAppFormBloc),
          ],
        );
      }),
    );
  }
}