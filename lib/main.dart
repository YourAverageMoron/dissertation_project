import 'package:dissertation_project/routing/router.dart';
import 'package:flutter/material.dart';

import 'routing/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: HOME,
    );
  }
}