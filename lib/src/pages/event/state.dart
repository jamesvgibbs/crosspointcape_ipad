import 'package:crosspointcape_ipad/src/models/constants.dart';
import 'package:crosspointcape_ipad/src/models/media.dart';
import 'package:crosspointcape_ipad/src/pages/event/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html_unescape/html_unescape.dart';

class EventPageState extends State<EventPage>
    with SingleTickerProviderStateMixin {
  static TextStyle textstyleTile = TextStyle(
      color: Colors.white, fontWeight: FontWeight.w700, fontSize: 34.0);

  var unescape = new HtmlUnescape();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(
          unescape.convert(widget.event.title.rendered),
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.0),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildFeaturedMedia(widget.event.featuredMedia),
                  HtmlWidget(
                    widget.event.content.rendered,
                    onTapUrl: (url) => launcher(url),
                    textStyle: TextStyle(fontSize: 20.0),
                    hyperlinkColor: Color.fromRGBO(224, 224, 224, 1)
                  ),
                ],
              ),
            )
          ],
        ),
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
      child: Image.network(
        imgSource,
        fit: BoxFit.cover,
      ),
    );
  }
}
