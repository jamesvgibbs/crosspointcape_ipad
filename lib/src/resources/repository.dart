import 'package:crosspointcape_ipad/src/models/event.dart';
import 'package:crosspointcape_ipad/src/resources/event_api_provider.dart';

class Repository {
  final eventApiProvider = EventApiProvider();

  Future<List<Event>> fetchAllEvents() => eventApiProvider.fetchList();
  Future<Event> fetchEvent(int id) => eventApiProvider.fetchOne(id);
}
