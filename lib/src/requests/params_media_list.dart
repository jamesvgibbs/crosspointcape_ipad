import 'package:crosspointcape_ipad/src/models/constants.dart';

class ParamsMediaList {
  final WordPressContext context;
  final int pageNum;
  final int perPage;
  final String searchQuery;
  final String afterDate;
  final List<int> includeAuthorIDs;
  final List<int> excludeAuthorIDs;
  final String beforeDate;
  final List<int> excludeMediaIDs;
  final List<int> includeMediaIDs;
  final int offset;
  final Order order;
  final MediaOrderBy orderBy;
  final List<int> includeParentIDs;
  final List<int> excludeParentIDs;
  final String slug;
  final MediaType mediaType;
  final String mimeType;

  ParamsMediaList({
    this.context = WordPressContext.view,
    this.pageNum = 1,
    this.perPage = 10,
    this.searchQuery = '',
    this.afterDate = '',
    this.includeAuthorIDs,
    this.excludeAuthorIDs,
    this.beforeDate = '',
    this.excludeMediaIDs,
    this.includeMediaIDs,
    this.offset,
    this.order = Order.desc,
    this.orderBy = MediaOrderBy.date,
    this.excludeParentIDs,
    this.includeParentIDs,
    this.slug = '',
    this.mediaType,
    this.mimeType = '',
  });

  Map<String, String> toMap() {
    return {
      'context': '${enumStringToName(this.context.toString())}',
      'page': '${this.pageNum}',
      'per_page': '${this.perPage}',
      'search': '${this.searchQuery}',
      'after': '${this.afterDate}',
      'author': '${listToUrlString(this.includeAuthorIDs)}',
      'author_exclude': '${listToUrlString(this.excludeAuthorIDs)}',
      'before': '${this.beforeDate}',
      'exclude': '${listToUrlString(excludeMediaIDs)}',
      'include': '${listToUrlString(includeMediaIDs)}',
      'offset': '${this.offset == null ? '' : this.offset}',
      'order': '${enumStringToName(this.order.toString())}',
      'orderby': '${enumStringToName(this.orderBy.toString())}',
      'parent': '${listToUrlString(includeParentIDs)}',
      'parent_exclude': '${listToUrlString(excludeParentIDs)}',
      'slug': '${this.slug}',
      'media_type':
          '${this.mediaType == null ? '' : enumStringToName(this.mediaType.toString())}',
      'mime_type': '${this.mimeType}',
    };
  }

  @override
  String toString() {
    return constructUrlParams(toMap());
  }
}
