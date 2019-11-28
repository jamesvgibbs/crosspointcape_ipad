import 'package:crosspointcape_ipad/src/models/event.dart';
import 'package:crosspointcape_ipad/src/models/media.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventsList extends StatelessWidget {
  final ScrollController controller = ScrollController();
  final String title;
  final String content;
  final Media image;
  final Function onTap;
  final Event event;
  final unescape = new HtmlUnescape();

  EventsList({this.title, this.content, this.image, this.onTap, this.event});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () => onTap(event),
            child: _buildPostCard(
                title: title, content: content, featuredMedia: image),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard({
    String author,
    String title,
    String content,
    Media featuredMedia,
  }) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
            child: Text(
              unescape.convert(title),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
          _buildFeaturedMedia(featuredMedia),
          featuredMedia == null
              ? Divider()
              : SizedBox(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }

  Widget _buildFeaturedMedia(Media featuredMedia) {
    if (featuredMedia == null) {
      return SizedBox(
        width: 0.0,
        height: 0.0,
      );
    }
    String imgSource = featuredMedia.mediaDetails.sizes.full.sourceUrl;
    return Center(
      child: CachedNetworkImage(
        imageUrl: imgSource,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
    );
  }
}
