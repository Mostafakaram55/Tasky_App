import '../../domain/entities/user_entites.dart';

class UserModel extends UserEntity{
  UserModel({
    required String id,
    required String displayName,
    required String username,
    required  dynamic experienceYears,
    required  String address,
    required String level,
    required String createdAt,
    required String updatedAt,

  }):super(
      id: id,
      address: address,
      displayName: displayName,
      experienceYears: experienceYears,
      level: level, username: username
  );
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      displayName :json['displayName'],
      username: json['username'],
      experienceYears : json['experienceYears'],
      address : json['address'],
      level : json['level'],
      createdAt : json['createdAt'],
      updatedAt : json['updatedAt'],
    );
  }
}