import 'package:delivery_practice01/common/model/model_with_id.dart';
import 'package:delivery_practice01/common/utils/utils_data.dart';
import 'package:delivery_practice01/user/model/model_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_rating.g.dart';

@JsonSerializable()
class ModelRating implements IModelWithId {
  final String id;
  final ModelUser user;
  final int rating;
  final String content;
  @JsonKey(fromJson: UtilsData.listPathsToUrl)
  final List<String> imgUrls;

  ModelRating({
    required this.id,
    required this.user,
    required this.rating,
    required this.content,
    required this.imgUrls,
  });

  factory ModelRating.fromJson(Map<String, dynamic> json) => _$ModelRatingFromJson(json);
}
