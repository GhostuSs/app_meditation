import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserData extends HiveObject{
  UserData({this.name,this.choose,this.phone,this.mail});
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? phone;
  @HiveField(2)
  List<String>? choose;
  @HiveField(3)
  String? mail;
}