import 'package:easy_bill/Controllers/API_Controllers/Returns/AddReturnService.dart';
import 'package:easy_bill/Views/home_screens/Common/FloatingButton.dart';
import 'package:flutter/material.dart';
import 'package:easy_bill/Views/home_screens/Common/AppBar.dart';
import 'package:easy_bill/Controllers/API_Controllers/Stock/AddItemService.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddReturnPage extends StatefulWidget {
  AddReturnPage({Key key}) : super(key: key);

  @override
  _AddReturnPageState createState() => _AddReturnPageState();
}

clearContollers() {
  nameController.clear();
  descriptionController.clear();
  dateController.clear();
}

bool isLoading = false;
final nameController = TextEditingController();
final descriptionController = TextEditingController();
final dateController = TextEditingController();

class _AddReturnPageState extends State<AddReturnPage> {
  showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1980, 12, 31),
      maxTime: DateTime.now(),
      onChanged: (date) {
        //print the date
        print('change $date');
      },
      onConfirm: (date) {
        final bday = "$date";

        var formatter = new DateFormat('yyyy-MM-dd');
        var selecteddate = formatter.format(date);

        setState(() {
          dateController.text = selecteddate;
          //eaqual the bday value to text editing controller
        });

        //print the bday
        print('confirm ' + selecteddate.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingButton(context),
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "ADD RETURN",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
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
              GestureDetector(
                onTap: () {
                  showDatePicker();
                },
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFE0E0E0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          height: 54,
                          width: MediaQuery.of(context).size.width / 1.5,
                          // margin: EdgeInsets.only(top: 15),
                          child: TextField(
                            controller: dateController,
                            enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Return Date",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // margin: const EdgeInsets.only( top: 10),
                        child: Container(
                          child: Icon(
                            FontAwesomeIcons.solidCalendarAlt,
                            size: 30,
                            color: Color(0XFFFF5E3A),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              isLoading
                  ? LinearProgressIndicator()
                  : Row(
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
                              padding:
                                  const EdgeInsets.only(left: 35.0, top: 10),
                              child: Text("Clear"),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            SharedPreferences login =
                                await SharedPreferences.getInstance();
                            final body = {
                              "name": nameController.text,
                              "description": descriptionController.text,
                              "returnDate": dateController.text,
                              "token": login.getString("gettoken")
                            };

                            AddReturnService.addReturn(body).then((success) {
                              if (success) {
                                print("saved");
                                clearContollers();
                                setState(() {
                                  isLoading = false;
                                });
                                Alert(
                                  style: AlertStyle(
                                    animationType: AnimationType.fromTop,
                                    isCloseButton: false,
                                    isOverlayTapDismiss: false,
                                    descStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    animationDuration:
                                        Duration(milliseconds: 400),
                                    alertBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    titleStyle: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  context: context,
                                  type: AlertType.success,
                                  title: "Save Success",
                                  desc: "Your Record has been saved",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      width: 120,
                                    )
                                  ],
                                ).show();
                              } else {
                                print("failed");
                                setState(() {
                                  isLoading = false;
                                });
                                Alert(
                                  style: AlertStyle(
                                    animationType: AnimationType.fromTop,
                                    isCloseButton: false,
                                    isOverlayTapDismiss: false,
                                    descStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    animationDuration:
                                        Duration(milliseconds: 400),
                                    alertBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      side: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    titleStyle: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  context: context,
                                  type: AlertType.error,
                                  title: "Save Failed",
                                  desc: "Check Again",
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "OK",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      width: 120,
                                    )
                                  ],
                                ).show();
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
                              padding:
                                  const EdgeInsets.only(left: 35.0, top: 10),
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
