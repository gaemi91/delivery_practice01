import 'package:json_annotation/json_annotation.dart';

part 'model_cursor_pagination.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationLoading extends CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({required this.message});
}

@JsonSerializable(genericArgumentFactories: true)
class CursorPagination<T> extends CursorPaginationBase {
  final ModelCursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  factory CursorPagination.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);

  CursorPagination copyWith({ModelCursorPaginationMeta? meta, List<T>? data}) {
    return CursorPagination(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }
}

class CursorPaginationRefresh<T> extends CursorPagination {
  CursorPaginationRefresh({required super.meta, required super.data});
}

class CursorPaginationFetchMore<T> extends CursorPagination {
  CursorPaginationFetchMore({required super.meta, required super.data});
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
