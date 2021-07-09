class ReviewChecklistData {
  List<ChecklistListViewData>? data;

  ReviewChecklistData({this.data});

  ReviewChecklistData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ChecklistListViewData>.empty(growable: true);
      json['data'].forEach((v) {
        data!.add(new ChecklistListViewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChecklistListViewData {
  int? id;
  String? checklist;
  String? mainCategory;
  String? reviewType;
  String? createdAt;

  ChecklistListViewData(
      {this.id,
      this.checklist,
      this.mainCategory,
      this.reviewType,
      this.createdAt});

  ChecklistListViewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checklist = json['checklist'];
    mainCategory = json['main_category'];
    reviewType = json['review_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['checklist'] = this.checklist;
    data['main_category'] = this.mainCategory;
    data['review_type'] = this.reviewType;
    data['created_at'] = this.createdAt;
    return data;
  }
}
