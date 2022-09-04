import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputWidget extends StatefulWidget {
  Function addItem;
  InputWidget({required this.addItem});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  var name = TextEditingController();
  DateTime? tdate;
  var amt = TextEditingController();

  Widget inputwidget(BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          border:
              Border.all(color: Color.fromRGBO(85, 52, 50, 100), width: 3.0)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, top: 1, right: 10, bottom: 1),
            // margin: EdgeInsets.all(2),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              controller: name,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 1, right: 10, bottom: 5),
            // margin: EdgeInsets.all(2),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Amount",
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              controller: amt,
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      (tdate == null)
                          ? "No date Chosen"
                          : "picked:${DateFormat.yMMMd().format(tdate!)}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      child: Text("Pick a date!"),
                      onPressed: () => {
                        showDatePicker(
                                context: ctx,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1990),
                                lastDate: DateTime.now())
                            .then((value) => tdate = value),
                      },
                      textColor: Colors.amber,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text("Add"),
                onPressed: () {
                  if (tdate == null || amt == null || name == null) {
                    return;
                  }
                  widget.addItem(name.text, double.parse(amt.text), tdate);
                  Navigator.of(context).pop();
                },
                color: Colors.purpleAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      child: inputwidget(context),
    );
  }
}
