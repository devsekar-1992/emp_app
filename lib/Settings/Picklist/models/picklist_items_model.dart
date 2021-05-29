class PicklistItemsModel {
  late Data data;

  PicklistItemsModel({required this.data});

  PicklistItemsModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  late Users users;
  late TaskStatus taskStatus;

  Data({required this.users, required this.taskStatus});

  Data.fromJson(Map<String, dynamic> json) {
    users = (json['users'] != null ? new Users.fromJson(json['users']) : null)!;
    taskStatus = (json['taskStatus'] != null
        ? new TaskStatus.fromJson(json['taskStatus'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users.toJson();
    }
    if (this.taskStatus != null) {
      data['taskStatus'] = this.taskStatus.toJson();
    }
    return data;
  }
}

class Users {
  late bool status;
  late List<UserList> userList;

  Users({required this.status, required this.userList});

  Users.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['userList'] != null) {
      userList = new List<UserList>.empty(growable: true);
      json['userList'].forEach((v) {
        userList.add(new UserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userList != null) {
      data['userList'] = this.userList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserList {
  late String fullName;
  late int id;

  UserList({required this.fullName, required this.id});

  UserList.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['id'] = this.id;
    return data;
  }
}

class TaskStatus {
  late bool status;
  late List<StatusList> statusList;

  TaskStatus({required this.status, required this.statusList});

  TaskStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['statusList'] != null) {
      statusList = new List<StatusList>.empty(growable: true);
      json['statusList'].forEach((v) {
        statusList.add(new StatusList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    // ignore: unnecessary_null_comparison
    if (this.statusList != null) {
      data['statusList'] = this.statusList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatusList {
  late int statusId;
  late String statusName;

  StatusList({required this.statusId, required this.statusName});

  StatusList.fromJson(Map<String, dynamic> json) {
    statusId = json['status_id'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_id'] = this.statusId;
    data['status_name'] = this.statusName;
    return data;
  }
}
