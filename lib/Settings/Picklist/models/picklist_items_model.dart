class PicklistItemsModel {
  late PicklistData data;

  PicklistItemsModel({required this.data});

  PicklistItemsModel.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null
        ? new PicklistData.fromJson(json['data'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class PicklistData {
  late Users users;
  late TaskStatus taskStatus;
  late ReviewStatus reviewStatus;
  late MainCategories mainCategories;

  PicklistData(
      {required this.users,
      required this.taskStatus,
      required this.reviewStatus,
      required this.mainCategories});

  PicklistData.fromJson(Map<String, dynamic> json) {
    users = (json['users'] != null ? new Users.fromJson(json['users']) : null)!;
    taskStatus = (json['taskStatus'] != null
        ? new TaskStatus.fromJson(json['taskStatus'])
        : null)!;
    reviewStatus = (json['reviewStatus'] != null
        ? new ReviewStatus.fromJson(json['reviewStatus'])
        : null)!;
    mainCategories = (json['mainCategories'] != null
        ? new MainCategories.fromJson(json['mainCategories'])
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
    if (this.reviewStatus != null) {
      data['reviewStatus'] = this.reviewStatus.toJson();
    }
    if (this.mainCategories != null) {
      data['mainCategories'] = this.mainCategories.toJson();
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

class ReviewStatus {
  late bool? status;
  late List<ReviewStatusList> reviewStatusList;

  ReviewStatus({this.status, required this.reviewStatusList});

  ReviewStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['reviewStatusList'] != null) {
      reviewStatusList = new List<ReviewStatusList>.empty(growable: true);
      json['reviewStatusList'].forEach((v) {
        reviewStatusList.add(new ReviewStatusList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.reviewStatusList != null) {
      data['reviewStatusList'] =
          this.reviewStatusList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReviewStatusList {
  int? id;
  String? name;

  ReviewStatusList({this.id, this.name});

  ReviewStatusList.fromJson(Map<String, dynamic> json) {
    id = json['review_type_id'];
    name = json['review_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_type_id'] = this.id;
    data['review_type'] = this.name;
    return data;
  }
}

class MainCategories {
  bool? status;
  List<ChecklistMainCategories>? checklistMainCategories;

  MainCategories({this.status, this.checklistMainCategories});

  MainCategories.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['checklistMainCategories'] != null) {
      checklistMainCategories =
          new List<ChecklistMainCategories>.empty(growable: true);
      json['checklistMainCategories'].forEach((v) {
        checklistMainCategories!.add(new ChecklistMainCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.checklistMainCategories != null) {
      data['checklistMainCategories'] =
          this.checklistMainCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChecklistMainCategories {
  int? id;
  int? reviewTypeId;
  String? mainCategories;
  String? description;
  Null createdAt;
  Null updatedAt;

  ChecklistMainCategories(
      {this.id,
      this.reviewTypeId,
      this.mainCategories,
      this.description,
      this.createdAt,
      this.updatedAt});

  ChecklistMainCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewTypeId = json['review_type_id'];
    mainCategories = json['main_categories'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review_type_id'] = this.reviewTypeId;
    data['main_categories'] = this.mainCategories;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
