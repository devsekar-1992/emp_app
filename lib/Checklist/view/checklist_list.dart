import 'package:emp_app/Checklist/bloc/review_checklist_bloc.dart';
import 'package:emp_app/Settings/Picklist/models/picklist_items_model.dart';
import 'package:emp_app/Tasks/widgets/task_edit_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChecklistListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ReviewChecklistBloc>().add(ReviewChecklistListView());
    return Builder(builder: (context) {
      return BlocListener<ReviewChecklistBloc, ReviewChecklistState>(
        listener: (context, state) {
          if (state is ReviewChecklistSuccess) {
            print('State Success');
            context.read<ReviewChecklistBloc>().add(ReviewChecklistListView());
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text('Review Checklist'),
            ),
            body: BlocListener<ReviewChecklistBloc, ReviewChecklistState>(
              listener: (context, state) {
                if (state is ReviewChecklistSuccess) {
                  print('State Success');
                  context
                      .read<ReviewChecklistBloc>()
                      .add(ReviewChecklistListView());
                }
              },
              child: BlocBuilder<ReviewChecklistBloc, ReviewChecklistState>(
                builder: (context, state) {
                  if (state is ReviewChecklistInitial) {
                    print('Review Checklist Initial');
                  }
                  if (state is ReviewChecklistLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ReviewChecklistLoaded) {
                    return makeBody(context, state.reviewChecklistList.data);
                  }
                  if (state is ReviewChecklistFailure) {
                    print(state.error);
                  }
                  return Center(
                    child: Container(
                      child: Text(
                        'Checklist',
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: _speedDial(context)),
      );
    });
  }

  Container makeBody(context, items) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            if (items != null) {
              return makeCard(context, items[index]);
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Card makeCard(context, data) => Card(
      color: Color.fromRGBO(64, 75, 96, .9),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: ListTile(
            mouseCursor: MouseCursor.defer,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    data.checklist,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(timeago.format(DateTime.parse(data.createdAt)).toString(),
                    style: TextStyle(color: Colors.white)),
              ],
            ),
            subtitle: Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Align(
                    child: Icon(Icons.account_circle, color: Colors.blue),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.0, right: 10, top: 2),
                    child: Text(data.mainCategory,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          ),
        ),
      ));

  SpeedDial _speedDial(context) {
    TextEditingController _reviewTxt = TextEditingController();
    String _reviewType = '';

    List<DropdownMenuItem<int>> _buildStatusList(List reviewerList) {
      // ignore: deprecated_member_use
      List<DropdownMenuItem<int>> items = List.empty(growable: true);
      for (ChecklistMainCategories reviewer in reviewerList) {
        items.add(DropdownMenuItem(
            value: reviewer.id,
            child: Text(reviewer.mainCategories.toString())));
      }
      return items;
    }

    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.remove,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      children: [
        SpeedDialChild(
            child: Icon(Icons.code),
            backgroundColor: Colors.purple,
            label: 'Pseudo Code',
            onTap: () {
              Navigator.pushNamed(context, 'review_list',
                  arguments: 'Pseudo Code');
            }),
        SpeedDialChild(
          child: Icon(Icons.reviews),
          backgroundColor: Colors.indigoAccent,
          label: 'Code Review',
          onTap: () {
            _reviewModalForm(context, _reviewTxt);
          },
        )
      ],
    );
  }

  Future<dynamic> _reviewModalForm(
      BuildContext context, TextEditingController _reviewTxt) {
    final reviewChecklistBloc = BlocProvider.of<ReviewChecklistBloc>(context);
    reviewChecklistBloc.add(LoadAddReviewModal());
    return showModalBottomSheet(
        isDismissible: true,
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        context: context,
        builder: (context) {
          return BlocListener<ReviewChecklistBloc, ReviewChecklistState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            child: BlocBuilder<ReviewChecklistBloc, ReviewChecklistState>(
              builder: (context, state) {
                if (state is LoadAddReviewModalSuccess) {
                  print(state.picklistData);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              'Add Review Checklist for Code Review Process',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.cancel,
                              color: Colors.white,
                              textDirection: TextDirection.rtl,
                            )
                          ],
                        ),
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: _reviewTxt,
                          decoration: InputDecoration(
                              hintText: 'Review Checklist Name'),
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Text')),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            reviewChecklistBloc.add(AddReviewChecklist());
                          },
                          child: Text('Add Review'),
                        ),
                      )
                    ],
                  );
                }
                if (state is ReviewChecklistFailure) {}
                return Container();
              },
            ),
          );
        });
  }
}
