import 'package:json_annotation/json_annotation.dart';

part 'model_cursor_pagination.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> {
  final ModelCursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ModelCursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class ModelCursorPaginationMeta {
  final int count;
  final bool hasMore;

  ModelCursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory ModelCursorPaginationMeta.fromJson(Map<String, dynamic> json) => _$ModelCursorPaginationMetaFromJson(json);
}
