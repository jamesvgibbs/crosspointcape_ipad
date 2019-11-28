import 'package:crosspointcape_ipad/src/models/event.dart';
import 'package:crosspointcape_ipad/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class EventBloc {
  final _repository = Repository();
  final _eventsFetcher = PublishSubject<List<Event>>();
  final _eventFetcher = PublishSubject<Event>();

  Observable<List<Event>> get allEvents => _eventsFetcher.stream;
  Observable<Event> get oneEvent => _eventFetcher.stream;

  fetchAllEvents() async {
    List<Event> items = await _repository.fetchAllEvents();
    _eventsFetcher.sink.add(items);
  }

  removeAllEvents() async {
    await _eventsFetcher.drain();
    _eventsFetcher.close();
  }

  fetchOneEvent(int id) async {
    Event item = await _repository.fetchEvent(id);
    _eventFetcher.sink.add(item);
  }

  dispose() async {
    await _eventsFetcher.drain();
    _eventsFetcher.close();
    await _eventFetcher.drain();
    _eventFetcher.close();
  }
}

final eventBloc = EventBloc();
