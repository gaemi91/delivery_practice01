// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_cursor_pagination_more.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursorPaginationMore _$CursorPaginationMoreFromJson(
        Map<String, dynamic> json) =>
    CursorPaginationMore(
      after: json['after'] as String?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$CursorPaginationMoreToJson(
        CursorPaginationMore instance) =>
    <String, dynamic>{
      'after': instance.after,
      'count': instance.count,
    };
