
import '../../domain/entites/task_entity.dart';

class TaskModel  extends TaskEntity {
   TaskModel({
    required image,
    required title,
    required desc,
    required priority,
    required status,
    required user,
    required id,
    required createdAt,
    required updatedAt,
    required v,
  }) : super (
    image: image,
    createdAt: createdAt,
    desc: desc,
    priority: priority,
    status: status,
    title: title,
    updatedAt: updatedAt,
    user: user,
    v: v,
    id: id,
  );

  factory TaskModel.fromMap(Map<String, dynamic> json) {
    return TaskModel(
      image: json["image"]??'',
      title: json["title"]??'',
      desc: json["desc"]??'',
      priority: json["priority"]??'',
      status: json["status"]??'',
      user: json["user"]??'',
      id: json["_id"],
      createdAt:json["createdAt"]as String,
      updatedAt:json["updatedAt"] as String,
      v: json["__v"]??0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "title": title,
      "desc": desc,
      "priority": priority,
      "status": status,
      "user": user,
      "_id": id,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
    };
  }
}