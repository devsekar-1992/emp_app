class TaskForm {
  // ignore: non_constant_identifier_names
  late int? task_id;
  // ignore: non_constant_identifier_names
  String? review_date;
  String? url;
  int? status;
  // ignore: non_constant_identifier_names
  int? review_type_id;
  // ignore: non_constant_identifier_names
  int? user_id;
  // ignore: non_constant_identifier_names
  int? updated_by;
  // ignore: non_constant_identifier_names
  String? request_method;

  TaskForm(
      {
      // ignore: non_constant_identifier_names
      this.task_id,
      // ignore: non_constant_identifier_names
      this.review_date,
      this.url,
      this.status,
      // ignore: non_constant_identifier_names
      this.user_id,
      // ignore: non_constant_identifier_names
      this.updated_by,
      // ignore: non_constant_identifier_names
      this.request_method,
      // ignore: non_constant_identifier_names
      this.review_type_id});
  factory TaskForm.fromJson(Map<String, dynamic> json) => TaskForm(
      task_id: json['task_id'],
      review_date: json['review_date'],
      url: json['url'],
      status: json['status'],
      user_id: json['user_id'],
      updated_by: json['updated_by'],
      request_method: json['request_method'],
      review_type_id: json['review_type_id']);
  Map<String, dynamic> toJson() {
    var map = {
      'task_id': this.task_id ?? '',
      'review_date': this.review_date ?? '',
      'url': this.url ?? '',
      'status': this.status ?? '',
      'user_id': this.user_id ?? '',
      'updated_by': this.updated_by ?? '',
      'request_method': this.request_method ?? '',
      'review_type_id': this.review_type_id ?? ''
    };

    return map;
  }
}
