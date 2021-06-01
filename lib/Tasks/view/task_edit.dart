import 'dart:async';
import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:emp_app/Settings/Picklist/models/picklist_items_model.dart';
import 'package:emp_app/Tasks/bloc/detail/task_detail_bloc.dart';
import 'package:emp_app/Tasks/bloc/edit/bloc/task_edit_bloc_bloc.dart';
import 'package:emp_app/Tasks/bloc/task_event.dart';
import 'package:emp_app/Tasks/models/task_edit_model.dart';
import 'package:emp_app/Tasks/widgets/task_edit_dropdown.dart';
import 'package:emp_app/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late String requestMethod;
  TextEditingController reviewDate = TextEditingController();
  TextEditingController url = TextEditingController();
  TextEditingController reviewStatusCtrl = TextEditingController();
  final format = DateFormat("dd-MM-yyyy");

  int? selectedUser = 1;
  int? selectedStatus = 1;
  int? selectedReviewType = 1;
  List<DropdownMenuItem<int>> _buildList(List reviewerList) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<int>> items = List.empty(growable: true);
    for (UserList reviewer in reviewerList) {
      items.add(
          DropdownMenuItem(value: reviewer.id, child: Text(reviewer.fullName)));
    }
    return items;
  }

  List<DropdownMenuItem<int>> _buildStatusList(List reviewerList) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<int>> items = List.empty(growable: true);
    for (StatusList reviewer in reviewerList) {
      items.add(DropdownMenuItem(
          value: reviewer.statusId,
          child: Text(reviewer.statusName.toString())));
    }
    return items;
  }

  List<DropdownMenuItem<int>> _buildReviewTypeList(List reviewerList) {
    // ignore: deprecated_member_use
    List<DropdownMenuItem<int>> items = List.empty(growable: true);
    for (ReviewStatusList reviewer in reviewerList) {
      items.add(DropdownMenuItem(
          value: reviewer.id, child: Text(reviewer.name.toString())));
    }
    return items;
  }

  EditData taskForm = EditData();
  late DateTime currentValue = DateTime.now();
  @override
// ignore: override_on_non_overriding_member
  void initState() {
    if (widget.taskReviewId != 0) {
      this.requestMethod = 'update';
    } else {
      this.requestMethod = 'add';
    }
    super.initState();
  }

  late TaskDetailBloc taskDetailBloc;
  late TaskEditBlocBloc taskEditBlocBloc;
  @override
  Widget build(BuildContext context) {
    taskDetailBloc = BlocProvider.of<TaskDetailBloc>(context);
    taskEditBlocBloc = BlocProvider.of<TaskEditBlocBloc>(context);
    print(taskDetailBloc.state);
    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: BlocListener<TaskEditBlocBloc, TaskEditBlocState>(
          listener: (context, state) {
            if (state is TaskEditBlocSuccessSave) {
              taskDetailBloc.add(TaskDetail(taskId: widget.taskId));
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<TaskEditBlocBloc, TaskEditBlocState>(
            builder: (context, state) {
              print('Edit view builder');
              print(state);

              if (state is TaskEditBlocInitial) {
                print('Task Edit Block Initial');
              }
              if (state is TaskEditBlocLoading) {
                return CircularProgressIndicator();
              }
              if (state is TaskEditBlocSuccess) {
                taskForm = state.taskEditModel;
                print(this.requestMethod);
                if (taskForm.reviewDate != null) {
                  currentValue = DateTime.parse(taskForm.reviewDate!);
                }
                print('Review Date Controller');
                print(taskForm.status);
                return Container(
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
                          onChanged: (value) {
                            print('Onchange');
                            print(DateFormat('yyyy-MM-dd').format(value!));
                            if (DateFormat('yyyy-MM-dd').format(value) !=
                                '0009-11-11') {
                              currentValue = value;
                              reviewDate.text =
                                  DateFormat('yyyy-MM-dd').format(currentValue);
                              taskForm.reviewDate = reviewDate.text;
                            }
                          },
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: 'Review Date'),
                          format: format,
                          initialValue: currentValue,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                              context: context,
                              initialDate: currentValue!,
                              firstDate: DateTime(2016),
                              lastDate: DateTime(2022),
                            );
                          }),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'URL Should not be empty';
                          }
                          return null;
                        },
                        initialValue: taskForm.url,
                        onChanged: (value) {
                          taskForm.url = value;
                        },
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.blue),
                            labelText: 'URL'),
                      ),
                      TaskFormDropdown(
                        onChanged: (value) {
                          setState(() {
                            taskForm.userId = value;
                          });
                        },
                        onValidate: (value) {
                          if (value == '') {
                            return 'Please select a reviewer';
                          }
                          return null;
                        },
                        dropdownMenuItemList:
                            _buildList(state.picklistData.users.userList),
                        selectedValue: taskForm.userId ?? 1,
                      ),
                      TaskFormDropdown(
                        onChanged: (value) {
                          taskForm.status = value;
                        },
                        onValidate: (value) {
                          if (value == '') {
                            return 'Please select a status';
                          }
                          return null;
                        },
                        dropdownMenuItemList: _buildStatusList(
                            state.picklistData.taskStatus.statusList),
                        selectedValue: taskForm.status ?? 1,
                      ),
                      TaskFormDropdown(
                        onChanged: (value) {
                          setState(() {
                            taskForm.reviewTypeId = value;
                          });
                        },
                        onValidate: (value) {
                          if (value == '') {
                            return 'Please select a review type';
                          }
                          return null;
                        },
                        dropdownMenuItemList: _buildReviewTypeList(
                            state.picklistData.reviewStatus.reviewStatusList),
                        selectedValue: taskForm.reviewTypeId ?? 1,
                      ),
                      Container(
                        height: 50.0,
                        child: BottomAppBar(
                          elevation: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                  onPressed: () {
                                    BlocProvider.of<TaskEditBlocBloc>(context)
                                        .close();
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel')),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      var currentUserInstance =
                                          await AuthRequest()
                                              .getCurrentUserId();
                                      var currentUser =
                                          jsonDecode(currentUserInstance!);
                                      //taskForm.reviewDate = reviewDate.text;
                                      taskForm.reviewTypeId =
                                          selectedReviewType;
                                      taskForm.status = taskForm.status;
                                      taskForm.userId = selectedUser;
                                      taskForm.taskId = widget.taskId;
                                      taskForm.taskReviewId =
                                          taskForm.taskReviewId;
                                      // currentUser['user']['id'];
                                      taskForm.requestMethod = requestMethod;

                                      BlocProvider.of<TaskEditBlocBloc>(context)
                                          .add(CreateTask(taskForm: taskForm));
                                    }
                                  },
                                  child: Text('Save'))
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              }
              return Container(
                child: Text('Wait edit view page is under development'),
              );
            },
          ),
        ),
      ),
    );
  }

  convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    return formatDate(todayDate, [yyyy, '-', mm, '-', dd]);
  }

  @override
  void dispose() {
    this.reviewDate.clear();
    this.url.clear();
    super.dispose();
  }
}
