import 'package:delivery_practice01/common/utils/utils_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_user.g.dart';

@JsonSerializable()
class ModelUser {
  final String id;
  final String username;
  @JsonKey(fromJson: UtilsData.pathToUrl)
  final String imageUrl;

  ModelUser({
    required this.id,
    required this.username,
    required this.imageUrl,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) => _$ModelUserFromJson(json);
}
