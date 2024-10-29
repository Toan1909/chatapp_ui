import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

myDialog(
    {required BuildContext context,
    required String title,
    required String message,
    required Icon icon
    }) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            icon: icon,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"))
            ],
          ));
}
