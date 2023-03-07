import 'package:flutter/material.dart';
import 'package:movies/screens/screens.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const HomeScreen(),
    '/detailMovie': (BuildContext context) => const DetailMovie(),
  };
}
