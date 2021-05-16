class TaskDetailModel {
  late List<Data> data;

  TaskDetailModel({required this.data});

  TaskDetailModel.fromJson(Map<String, dynamic> json) {
    print('json');
    print(json['data']);
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      print('data before');
      data = new List<Data>.empty(growable: true);

      [json['data']].forEach((v) {
        print('loop');
        print(v);
        data.add(new Data.fromJson(v));
      });
      print('data after');
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class Data {
  late String taskName;
  late String taskCreatedBy;
  late String taskCreatedAt;
  late TaskAssigneeDetails taskAssigneeDetails;
  late TaskDetails taskDetails;
  late List<TaskReview>? taskReview;

  Data(
      {required this.taskName,
      required this.taskCreatedBy,
      required this.taskCreatedAt,
      required this.taskAssigneeDetails,
      required this.taskDetails,
      required this.taskReview});

  Data.fromJson(Map<String, dynamic> json) {
    taskName = json['task_name'];
    taskCreatedBy = json['task_created_by'];
    taskCreatedAt = json['task_created_at'];
    taskAssigneeDetails = (json['task_assignee_details'] != null
        ? new TaskAssigneeDetails.fromJson(json['task_assignee_details'])
        : null)!;
    taskDetails = (json['task_details'] != null
        ? new TaskDetails.fromJson(json['task_details'])
        : null)!;
    if (json['task_review'] != null) {
      // ignore: deprecated_member_use
      taskReview = new List<TaskReview>.empty(growable: true);
      json['task_review'].forEach((v) {
        taskReview!.add(new TaskReview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_name'] = this.taskName;
    data['task_created_by'] = this.taskCreatedBy;
    data['task_created_at'] = this.taskCreatedAt;
    if (this.taskAssigneeDetails != null) {
      data['task_assignee_details'] = this.taskAssigneeDetails.toJson();
    }
    if (this.taskDetails != null) {
      data['task_details'] = this.taskDetails.toJson();
    }
    if (this.taskReview != null) {
      data['task_review'] = this.taskReview!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskAssigneeDetails {
  late String name;
  late int id;

  TaskAssigneeDetails({required this.name, required this.id});

  TaskAssigneeDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class TaskDetails {
  late String taskVersion;
  late String taskUrl;
  late String taskProject;

  TaskDetails(
      {required this.taskVersion,
      required this.taskUrl,
      required this.taskProject});

  TaskDetails.fromJson(Map<String, dynamic> json) {
    taskVersion = json['task_version'];
    taskUrl = json['task_url'];
    taskProject = json['task_project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_version'] = this.taskVersion;
    data['task_url'] = this.taskUrl;
    data['task_project'] = this.taskProject;
    return data;
  }
}

class TaskReview {
  late int reviewId;
  late String reviewDate;
  late int taskId;
  late String url;
  late int userId;
  late String reviewType;
  late String createdBy;
  late Status status;
  late String reviewCreatedAt;
  late String reviewUpdatedAt;

  TaskReview(
      {required this.reviewId,
      required this.reviewDate,
      required this.taskId,
      required this.url,
      required this.userId,
      required this.reviewType,
      required this.createdBy,
      required this.status,
      required this.reviewCreatedAt,
      required this.reviewUpdatedAt});

  TaskReview.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    reviewDate = (json['review_date'])!;
    taskId = json['task_id'];
    url = json['url'];
    userId = json['user_id'];
    reviewType = json['review_type'];
    createdBy = json['created_by'];
    status =
        (json['status'] != null ? new Status.fromJson(json['status']) : null)!;
    reviewCreatedAt = json['review_created_at'];
    reviewUpdatedAt = json['review_updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['review_date'] = this.reviewDate;
    data['task_id'] = this.taskId;
    data['url'] = this.url;
    data['user_id'] = this.userId;
    data['review_type'] = this.reviewType;
    data['created_by'] = this.createdBy;
    // ignore: unnecessary_null_comparison
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['review_created_at'] = this.reviewCreatedAt;
    data['review_updated_at'] = this.reviewUpdatedAt;
    return data;
  }
}

class Status {
  late int statusId;
  late String status;

  Status({required this.statusId, required this.status});

  Status.fromJson(Map<String, dynamic> json) {
    statusId = json['status_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_id'] = this.statusId;
    data['status'] = this.status;
    return data;
  }
}
