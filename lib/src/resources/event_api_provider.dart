import 'dart:convert';
import 'package:crosspointcape_ipad/src/requests/params_event_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:crosspointcape_ipad/src/models/event.dart';
import 'package:crosspointcape_ipad/src/models/media.dart';
import 'package:crosspointcape_ipad/src/models/constants.dart';
import 'package:crosspointcape_ipad/src/models/wordpress_error.dart';
import 'package:crosspointcape_ipad/src/requests/params_media_list.dart';

class EventApiProvider {

  Future<List<Event>> fetchList() async {
    final StringBuffer url = new StringBuffer(BASE_URL + URL_EVENTS);
    var params = ParamsEventList();
    url.write(params.toString());

    final response = await http.get(url.toString());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<Event> events = new List<Event>();
      final list = json.decode(response.body);
      for (final event in list) {
        events.add(await _eventBuilder(
          event: Event.fromJson(event),
          setFeaturedMedia: true,
        ));
      }
      return events;
    } else {
      try {
        WordPressError err =
            WordPressError.fromJson(json.decode(response.body));
        throw err;
      } catch (e) {
        throw new WordPressError(message: response.body);
      }
    }
  }

  Future<Event> fetchOne(int id) async {
    final response = await http.get('$BASE_URL/$URL_EVENTS/$id');
    if (response.statusCode == 200) {
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Event> _eventBuilder({
    Event event,
    bool setFeaturedMedia = false,
  }) async {
    if (setFeaturedMedia) {
      List<Media> media = await fetchMediaList(
        params: ParamsMediaList(
          includeMediaIDs: [event.featuredMediaID],
        ),
      );
      if (media != null && media.length != 0) event.featuredMedia = media[0];
    }
    return event;
  }

  Future<List<Media>> fetchMediaList({@required ParamsMediaList params}) async {
    final StringBuffer url = new StringBuffer(BASE_URL + URL_MEDIA);

    url.write(params.toString());

    final response = await http.get(url.toString());

    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<Media> media = new List<Media>();
      final list = json.decode(response.body);
      list.forEach((m) {
        media.add(Media.fromJson(m));
      });
      return media;
    } else {
      try {
        WordPressError err =
            WordPressError.fromJson(json.decode(response.body));
        throw err;
      } catch (e) {
        throw new WordPressError(message: response.body);
      }
    }
  }
}
