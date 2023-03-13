import 'package:json_annotation/json_annotation.dart';

part 'model_cursor_pagination_more.g.dart';

@JsonSerializable()
class CursorPaginationMore {
  final String? after;
  final int? count;

  const CursorPaginationMore({this.after, this.count});

  factory CursorPaginationMore.fromJson(Map<String, dynamic> json) => _$CursorPaginationMoreFromJson(json);

  Map<String, dynamic> toJson() => _$CursorPaginationMoreToJson(this);

  CursorPaginationMore copyWith({String? after, int? count}) {
    return CursorPaginationMore(
      count: count ?? this.count,
      after: after ?? this.after,
    );
  }
}
