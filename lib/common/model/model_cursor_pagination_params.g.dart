// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_cursor_pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursorPaginationParams _$CursorPaginationParamsFromJson(
        Map<String, dynamic> json) =>
    CursorPaginationParams(
      after: json['after'] as String?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$CursorPaginationParamsToJson(
        CursorPaginationParams instance) =>
    <String, dynamic>{
      'after': instance.after,
      'count': instance.count,
    };
