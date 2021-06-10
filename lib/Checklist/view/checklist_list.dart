import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ChecklistListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Checklist'),
      ),
      body: Container(
        child: Text('Checklist'),
      ),
      floatingActionButton: _speedDial(context),
    );
  }

  SpeedDial _speedDial(context) {
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
            Navigator.pushNamed(context, 'review_list',
                arguments: 'Code Review');
          },
        )
      ],
    );
  }
}
