import 'package:easy_bill/Views/home_screens/Cart/AvailableList.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

floatingButton(context) {
  return FloatingActionButton(
    onPressed: null,
    child: Container(
        // color: Colors.amber,
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
            tooltip: "New Sale",
            icon: Icon(
              FontAwesomeIcons.plusCircle,
              color: Colors.black,
            ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AvailableListPage()));
            }),
      ],
    )),
  );
}
