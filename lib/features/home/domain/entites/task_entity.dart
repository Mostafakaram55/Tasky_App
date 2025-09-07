
class TaskEntity{
  final String image;
  final String title;
  final String desc;
  final String? priority;
  final String? status;
  final String user;
  final String createdAt;
  final dynamic updatedAt;
  final String id;
  final int v;
  TaskEntity(  {
    required this.image,
    required this.title,
    required  this.desc,
    required  this.priority,
    required  this.status,
    required  this.user,
    required  this.createdAt,
    required  this.updatedAt,
    required this.v,
    required this.id,
  });
}