import 'package:dissertation_project/kiwi_di/injector.dart';
import 'package:dissertation_project/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/simple_block_delegate.dart';
import 'routing/routes.dart';

void main(){
  setup();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: HOME,
    );
  }
}
