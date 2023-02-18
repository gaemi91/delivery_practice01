// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_cursor_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelCursorPagination<T> _$ModelCursorPaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ModelCursorPagination<T>(
      meta: ModelCursorPaginationMeta.fromJson(
          json['meta'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ModelCursorPaginationToJson<T>(
  ModelCursorPagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data.map(toJsonT).toList(),
    };

ModelCursorPaginationMeta _$ModelCursorPaginationMetaFromJson(
        Map<String, dynamic> json) =>
    ModelCursorPaginationMeta(
      count: json['count'] as int,
      hasMore: json['hasMore'] as bool,
    );

Map<String, dynamic> _$ModelCursorPaginationMetaToJson(
        ModelCursorPaginationMeta instance) =>
    <String, dynamic>{
      'count': instance.count,
      'hasMore': instance.hasMore,
    };
