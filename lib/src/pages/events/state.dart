import 'package:crosspointcape_ipad/src/blocs/events_bloc.dart';
import 'package:crosspointcape_ipad/src/models/event.dart';
import 'package:crosspointcape_ipad/src/pages/event/index.dart';
import 'package:crosspointcape_ipad/src/pages/events/index.dart';
import 'package:crosspointcape_ipad/src/widgets/events_list/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EventsPageState extends State<EventsPage>
    with SingleTickerProviderStateMixin {
  static TextStyle textstyleTile = TextStyle(
      color: Colors.white, fontWeight: FontWeight.w700, fontSize: 34.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(
          'Crosspoint Events',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.0),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                eventBloc.removeAllEvents();
                eventBloc.fetchAllEvents();
              },
            ),
        ],
      ),
      body: Center(
        child: EventsBuilder(),
      ),
    );
  }
}

class EventsBuilder extends StatefulWidget {
  EventsBuilder({Key key});

  @override
  EventsBuilderState createState() => EventsBuilderState();
}

class EventsBuilderState extends State<EventsBuilder> {
  final paddingCardsList = EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    eventBloc.fetchAllEvents();
    return StreamBuilder(
      stream: eventBloc.allEvents,
      builder: (context, AsyncSnapshot<List<Event>> snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(slivers: <Widget>[
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => EventsList(
                  onTap: goToEvent,
                  event: snapshot.data[index],
                  title: snapshot.data[index].title.rendered,
                  image: snapshot.data[index].featuredMedia,
                  content: snapshot.data[index].content.rendered,
                ),
                childCount: snapshot.data.length,
              ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 350.0,
                // mainAxisSpacing: 4.0,
                // crossAxisSpacing: 8.0,
                childAspectRatio: 1.125,
              ),
            )
          ]);
        } else if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
            style: TextStyle(color: Colors.red),
          );
        }

        return CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(Color.fromRGBO(192, 192, 192, 1.0)),
        );
      },
    );
  }

  void goToEvent(Event item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return EventPage(
          event: item,
        );
      }),
    );
  }
}
