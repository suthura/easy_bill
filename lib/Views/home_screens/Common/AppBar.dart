import 'package:flutter/material.dart';

appBar() {
  return AppBar(
    centerTitle: true,
    title: const Text('Easy Bill'),
    actions: <Widget>[
      logOut()
    ],
  );
}

logOut() {
  return InkWell(
    onTap: () => {},
    child: Icon(
      Icons.exit_to_app,
      color: Colors.black,
      size: 35,
    ),
  );
}
