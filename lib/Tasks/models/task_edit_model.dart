import 'package:date_format/date_format.dart';

class TaskEditModel {
  late List<EditData> data;

  TaskEditModel({required this.data});
  TaskEditModel.fromJson(Map<String, dynamic> json) {
    print('JSON');
    print(json);
    if (json['data'] != null) {
      data = new List<EditData>.empty(growable: true);
      json['data'].forEach((v) {
        data.add(new EditData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EditData {
  int? taskReviewId;
  int? taskId;
  String? reviewDate;
  int? userId;
  int? reviewTypeId;
  int? status;
  String? url;
  String? requestMethod;

  EditData(
      {this.taskReviewId,
      this.taskId,
      this.reviewDate,
      this.userId,
      this.reviewTypeId,
      this.status,
      this.url,
      this.requestMethod});

  EditData.fromJson(Map<String, dynamic> json) {
    taskReviewId = json['task_review_id'];
    taskId = json['task_id'];
    reviewDate = json['review_date'];
    userId = json['user_id'];
    reviewTypeId = json['review_type_id'];
    status = json['status'];
    url = json['url'];
    requestMethod = json['request_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_review_id'] = this.taskReviewId;
    data['task_id'] = this.taskId;
    data['review_date'] = this.reviewDate;
    data['user_id'] = this.userId;
    data['review_type_id'] = this.reviewTypeId;
    data['status'] = this.status;
    data['url'] = this.url;
    data['request_method'] = this.requestMethod;
    return data;
  }
}
