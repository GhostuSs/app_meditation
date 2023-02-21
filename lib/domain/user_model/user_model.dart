import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class UserData extends HiveObject {
  UserData({
    this.name,
    this.choose,
    this.phone,
    this.mail,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  @HiveField(0)
  String? name;
  @HiveField(1)
  String? phone;
  @HiveField(2)
  List<String>? choose;
  @HiveField(3)
  String? mail;

  /// Connect the generated [_$UserDataToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
