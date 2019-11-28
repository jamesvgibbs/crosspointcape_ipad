import 'package:crosspointcape_ipad/src/models/event.dart';
import 'package:crosspointcape_ipad/src/pages/event/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EventPage extends StatefulWidget {
  final Event event;
  EventPage({Key key, this.event, this.title}) : super(key: key);
  final String title;

  @override
  EventPageState createState() => EventPageState();
}