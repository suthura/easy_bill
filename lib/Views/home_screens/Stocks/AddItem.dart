import 'package:flutter/material.dart';
import 'package:easy_bill/Views/home_screens/Common/AppBar.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/AddItemService.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddItemPage extends StatefulWidget {
  AddItemPage({Key key}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

clearContollers() {
  nameController.clear();
  priceController.clear();
  descriptionController.clear();
  stockController.clear();
}

final nameController = TextEditingController();
final priceController = TextEditingController();
final descriptionController = TextEditingController();
final stockController = TextEditingController();

class _AddItemPageState extends State<AddItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
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
                onPressed: null),
          ],
        )),
      ),
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: nameController,
                decoration: new InputDecoration(
                  labelText: "Item Name",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: priceController,
                decoration: new InputDecoration(
                  labelText: "Item Price",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: false),
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: new InputDecoration(
                  labelText: "Item Description",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: stockController,
                decoration: new InputDecoration(
                  labelText: "Initial Stock",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pop();
                      clearContollers();
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: new BorderRadius.circular(25.0),
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, top: 10),
                        child: Text("Clear"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      final body = {
                        "name": nameController.text,
                        "price": priceController.text,
                        "description": descriptionController.text,
                        "stock": stockController.text,
                        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTkzMWU0NjYxYzVjMDAwMTcwYmNkYzUiLCJpYXQiOjE1ODY4NjU5MDB9.5rMJBsgdlMQZVqoFPU3iCHoLm44gn7v_HPPDc90F1DA"
                      };

                      AddItemService.addItem(body).then((success) {
                        if (success) {
                          print("saved");
                          clearContollers();
                        } else {
                          print("failed");
                        }
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: new BorderRadius.circular(25.0),
                        border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, top: 10),
                        child: Text("Save"),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
