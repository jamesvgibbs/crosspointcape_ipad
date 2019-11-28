import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

const BASE_URL = 'https://www.crosspointcape.com';
const URL_WP_BASE = '/wp-json/wp/v2';

const URL_MEDIA = '$URL_WP_BASE/media';
const URL_PAGES = '$URL_WP_BASE/pages';
const URL_POSTS = '$URL_WP_BASE/posts';
const URL_EVENTS = '$URL_WP_BASE/mp_event';
const URL_SERMONS = '$URL_WP_BASE/ctc_sermon';
const URL_SPEAKERS = '$URL_WP_BASE/ctc_sermon_speaker';
const URL_SERIES = '$URL_WP_BASE/ctc_sermon_series';

enum WordPressContext { view, embed, edit }

enum Order {
  asc,
  desc,
}

enum PostOrderBy {
  author,
  date,
  id,
  include,
  modified,
  parent,
  relevance,
  slug,
  title,
}
enum PostPageStatus {
  publish,
  future,
  draft,
  pending,
  private,
}

enum PageOrderBy {
  author,
  date,
  id,
  include,
  modified,
  parent,
  relevance,
  slug,
  title,
  menu_order,
}

enum MediaOrderBy {
  author,
  date,
  id,
  include,
  modified,
  parent,
  relevance,
  slug,
  title,
}
enum MediaType {
  image,
  video,
  audio,
  application,
}

String enumStringToName(String enumString) {
  return enumString.split('.')[1];
}

String listToUrlString<T>(List<T> items) {
  if (items == null || items.length == 0) return '';

  return items.join(',');
}

String constructUrlParams(Map<String, String> params) {
  StringBuffer p = new StringBuffer('/?');
  params.forEach((key, value) {
    if (value != '') {
      p.write('$key=$value');
      p.write('&');
    }
  });
  return p.toString();
}

Future launcher(url) async {
  if (Platform.isAndroid) {
    launcherBrowser(url);
  } else if (Platform.isIOS) {
    if (await canLaunch(url)) {
      await launch(url, enableJavaScript: true);
    } else {
      throw ('Could not launch $url');
    }
  }
}

Future launcherBrowser(url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw ('Could not launch $url');
  }
}
