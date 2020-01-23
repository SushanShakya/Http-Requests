import 'package:flutter/material.dart';

class DeleteUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text('User will be deleted'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'), 
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          ),
          FlatButton(
          child: Text('No'), 
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          )
      ],
      );
  }
}