import 'package:json_annotation/json_annotation.dart';

part 'default_response_model.g.dart';

@JsonSerializable()
class DefaultResponseModel {
  final bool success;

  DefaultResponseModel({required this.success});

  factory DefaultResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DefaultResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultResponseModelToJson(this);
}
