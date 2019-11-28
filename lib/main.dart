import 'package:crosspointcape_ipad/src/pages/events/index.dart';
import 'package:flutter/material.dart';

void main() async {
  try {
    runApp(new MyApp());
  } catch(error) {
    
  }
}

var routes = <String, WidgetBuilder>{
    "/": (BuildContext context) => new EventsPage()
  };

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      title: 'Crosspoint',
      theme: ThemeData.dark(),
      routes: routes,
    );
  }
}