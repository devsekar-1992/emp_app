class TaskListModel {
  late List<Data> data;

  TaskListModel({required this.data});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<Data>.empty(growable: true);
      print(json['data']);
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class Data {
  late int taskId;
  late String taskName;
  late String taskCreatedBy;
  late String taskCreatedAt;
  late TaskAssigneeDetails taskAssigneeDetails;
  late TaskDetails taskDetails;

  Data(
      {required this.taskId,
      required this.taskName,
      required this.taskCreatedBy,
      required this.taskCreatedAt,
      required this.taskAssigneeDetails,
      required this.taskDetails});

  Data.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskName = json['task_name'];
    taskCreatedBy = json['task_created_by'];
    taskCreatedAt = json['task_created_at'];
    taskAssigneeDetails = (json['task_assignee_details'] != null
        ? new TaskAssigneeDetails.fromJson(json['task_assignee_details'])
        : null)!;
    taskDetails = (json['task_details'] != null
        ? new TaskDetails.fromJson(json['task_details'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['task_name'] = this.taskName;
    data['task_created_by'] = this.taskCreatedBy;
    data['task_created_at'] = this.taskCreatedAt;
    // ignore: unnecessary_null_comparison
    if (this.taskAssigneeDetails != null) {
      data['task_assignee_details'] = this.taskAssigneeDetails.toJson();
    }
    // ignore: unnecessary_null_comparison
    if (this.taskDetails != null) {
      data['task_details'] = this.taskDetails.toJson();
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
