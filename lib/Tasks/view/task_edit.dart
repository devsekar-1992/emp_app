import 'dart:convert';

import 'package:emp_app/Tasks/widgets/task_edit_dropdown.dart';
import 'package:emp_app/services/Task/Task.dart';
import 'package:emp_app/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// ignore: must_be_immutable
class ReviewStatus {
  late final String statusName;
  late final int statusId;
  ReviewStatus({required this.statusId, required this.statusName});
}

class TaskType {
  final String taskTypeName;
  final int taskTypeId;
  TaskType({required this.taskTypeId, required this.taskTypeName});
}

class Reviewer {
  final String name;
  final int usrId;
  Reviewer({required this.usrId, required this.name});
}

// ignore: must_be_immutable
class TaskEditView extends StatefulWidget {
  int taskId;
  int taskReviewId;

  TaskEditView({required this.taskId, required this.taskReviewId});
  @override
  _TaskEditViewState createState() => _TaskEditViewState();
}

class _TaskEditViewState extends State<TaskEditView> {
  late String requestMethod;
  TextEditingController reviewDate = TextEditingController();
  TextEditingController url = TextEditingController();
  TextEditingController reviewStatusCtrl = TextEditingController();
  final format = DateFormat("dd-MM-yyyy");
  late DateTime currentValue;
  late ReviewStatus _selectedReviewStatus;
  List<ReviewStatus> reviewStatus = <ReviewStatus>[
    ReviewStatus(statusId: 0, statusName: 'Select Review Status'),
    ReviewStatus(statusId: 1, statusName: 'Pending'),
    ReviewStatus(statusId: 2, statusName: 'Approved')
  ];

  late List<DropdownMenuItem<ReviewStatus>> _reviewStatusDropdownList;
  List<DropdownMenuItem<ReviewStatus>> _buildReviewStatusList(
      List reviewStatusList) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<ReviewStatus>> items = List.empty(growable: true);
    for (ReviewStatus reviewStatus in reviewStatusList) {
      items.add(DropdownMenuItem(
          value: reviewStatus, child: Text(reviewStatus.statusName)));
    }
    return items;
  }

  _onchangeForReviewStatusDropdownList(ReviewStatus? newValue) {
    setState(() {
      _selectedReviewStatus = newValue!;
    });
  }

  late TaskType _selectedTaskType;
  List<TaskType> taskType = <TaskType>[
    TaskType(taskTypeId: 0, taskTypeName: 'Select Task Type'),
    TaskType(taskTypeId: 1, taskTypeName: 'Pseudo code'),
    TaskType(taskTypeId: 2, taskTypeName: 'Code Review')
  ];

  late List<DropdownMenuItem<TaskType>> _taskStatusDropdownList;
  List<DropdownMenuItem<TaskType>> _buildTaskTypeList(List taskTypeList) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<TaskType>> items = List.empty(growable: true);
    for (TaskType taskType in taskTypeList) {
      items.add(DropdownMenuItem(
          value: taskType, child: Text(taskType.taskTypeName)));
    }
    return items;
  }

  _onchangeForTaskTypeDropdownList(TaskType? newValue) {
    setState(() {
      _selectedTaskType = newValue!;
    });
  }

  late Reviewer _selectedReviewer;
  List<Reviewer> reviewer = <Reviewer>[
    Reviewer(usrId: 0, name: 'Select Reviewer'),
    Reviewer(usrId: 1, name: 'Aswin Kumar'),
    Reviewer(usrId: 2, name: 'Agash')
  ];

  late List<DropdownMenuItem<Reviewer>> _reviewerDropdownList;
  List<DropdownMenuItem<Reviewer>> _buildReviewerList(List reviewerList) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<Reviewer>> items = List.empty(growable: true);
    for (Reviewer reviewer in reviewerList) {
      items.add(DropdownMenuItem(value: reviewer, child: Text(reviewer.name)));
    }
    return items;
  }

  // ignore: unused_element
  _onchangeForReviewerDropdownList(Reviewer? newValue) {
    setState(() {
      _selectedReviewer = newValue!;
    });
  }

  @override
// ignore: override_on_non_overriding_member
  void initState() {
    currentValue = DateTime.now();
    print(currentValue);
    reviewDate.text = DateFormat('dd-MM-yyyy').format(currentValue);
    if (widget.taskReviewId != 0) {
      this.requestMethod = 'update';
    } else {
      this.requestMethod = 'add';
    }
    _reviewStatusDropdownList = _buildReviewStatusList(reviewStatus);
    _selectedReviewStatus = reviewStatus[0];
    _taskStatusDropdownList = _buildTaskTypeList(taskType);
    _selectedTaskType = taskType[0];
    _reviewerDropdownList = _buildReviewerList(reviewer);
    _selectedReviewer = reviewer[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                DateTimeField(
                    validator: (value) {
                      print(value);
                      // ignore: unrelated_type_equality_checks
                      if (value == '') {
                        // ignore: unnecessary_statements
                        return 'Review Date should not be empty';
                      }
                      return null;
                    },
                    initialValue: DateTime.now(),
                    controller: reviewDate,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: 'Review Date'),
                    format: format,
                    onShowPicker: (context, currentValue) {
                      print(currentValue);
                      return showDatePicker(
                          context: context,
                          initialDate: currentValue ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                    }),
                TextFormField(
                  validator: (value) {
                    print('review date');
                    if (value!.isEmpty) {
                      // ignore: unnecessary_statements
                      return 'URL Should not be empty';
                    }
                    return null;
                  },
                  controller: url,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.blue),
                      labelText: 'URL'),
                ),
                TaskFormDropdown<ReviewStatus>(
                    onValidate: (ReviewStatus? value) {
                      if (value!.statusId == 0) {
                        return 'Please select review status';
                      }
                      return null;
                    },
                    labelText: 'Review Status',
                    selectedValue: _selectedReviewStatus,
                    dropdownMenuItemList: _reviewStatusDropdownList,
                    onChanged: _onchangeForReviewStatusDropdownList),
                TaskFormDropdown<TaskType>(
                    onValidate: (TaskType? value) {
                      if (value!.taskTypeId == 0) {
                        return 'Please select task type';
                      }
                      return null;
                    },
                    labelText: 'Review Status',
                    selectedValue: _selectedTaskType,
                    dropdownMenuItemList: _taskStatusDropdownList,
                    onChanged: _onchangeForTaskTypeDropdownList),
                TaskFormDropdown<Reviewer>(
                    onValidate: (Reviewer? value) {
                      if (value!.usrId == 0) {
                        return 'Please select reviewer';
                      }
                      return null;
                    },
                    labelText: 'Who Reviewed?',
                    selectedValue: _selectedReviewer,
                    dropdownMenuItemList: _reviewerDropdownList,
                    onChanged: _onchangeForReviewerDropdownList),
              ]),
            )),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: BottomAppBar(
          elevation: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var currentUserInstance =
                          await AuthRequest().getCurrentUserId();
                      var currentUser = jsonDecode(currentUserInstance!);

                      var params = {
                        'task_id': widget.taskId,
                        'review_date': reviewDate.text,
                        'url': url.text,
                        'status': _selectedReviewStatus.statusId,
                        'review_type_id': _selectedTaskType.taskTypeId,
                        'user_id': _selectedReviewer.usrId,
                        'updated_by': currentUser['user']['id'],
                        'method': requestMethod
                      };
                      TaskRequest().saveTaskEdit(params);
                    }
                  },
                  child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }
}
