import 'package:crosspointcape_ipad/src/models/content.dart';
import 'package:crosspointcape_ipad/src/models/guid.dart';
import 'package:crosspointcape_ipad/src/models/media.dart';
import 'package:crosspointcape_ipad/src/models/title.dart';
import 'package:meta/meta.dart';

class Event {
  int id;
  String date;
  String dateGmt;
  Guid guid;
  String modified;
  String modifiedGmt;
  String slug;
  String type;
  String link;
  Title title;
  Content content;
  int featuredMediaID;
  List<Media> attachments;
  Media featuredMedia;

  Event(
      {this.date,
      this.dateGmt,
      this.slug,
      @required String title,
      @required String content,
      this.featuredMediaID})
      : this.title = new Title(rendered: title),
        this.content = new Content(rendered: content);

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    guid = json['guid'] != null ? new Guid.fromJson(json['guid']) : null;
    modified = json['modified'];
    modifiedGmt = json['modified_gmt'];
    slug = json['slug'];
    type = json['type'];
    link = json['link'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    featuredMediaID = json['featured_media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.date != null) data['date'] = this.date;
    if (this.dateGmt != null) data['date_gmt'] = this.dateGmt;
    if (this.slug != null) data['slug'] = this.slug;
    if (this.title != null) data['title'] = this.title.rendered;
    if (this.content != null) data['content'] = this.content.rendered;
    if (this.featuredMediaID != null)
      data['featured_media'] = this.featuredMediaID.toString();
    return data;
  }

  @override
  String toString() {
    return 'Event: { id: $id, title: ${title.rendered}}';
  }
}
