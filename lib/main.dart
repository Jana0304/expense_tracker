import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/widget/input_widget.dart';
import 'package:expense_tracker/widget/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/tansaction.dart';
import 'widget/chart.dart';
import 'dart:convert';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  // List<Brightness>
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        brightness: Brightness.values[1],
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  List<Transaction> transaction_details = <Transaction>[];
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    var dum = Transaction(
        id: '3',
        tranName: 'cloakroom bill',
        amount: 15,
        date: DateTime.now().subtract(Duration(days: 1)));

    String json = jsonEncode(dum);
    final pref = await SharedPreferences.getInstance();
    var map = pref.getStringList('jsonstring') ?? [];
    setState(() {
      for (var x in map) {
        Map<String, dynamic> m = jsonDecode(x);
        transaction_details.add(Transaction.fromJson(m));
        print(Transaction.fromJson(m));
      }
    });
  }

  bool Value = false;

  void additem(String name, double amt, DateTime tdate) async {
    var item = Transaction(
      id: (transaction_details.length).toString(),
      tranName: name,
      amount: amt,
      date: tdate,
    );
    String? jsonitem = jsonEncode(item);
    print(jsonitem);
    Map<String, dynamic> map = jsonDecode(jsonitem);
    final pref = await SharedPreferences.getInstance();
    transaction_details.add(item);
    List<String> jsonlist = [];
    setState(() {
      for (var x in transaction_details) {
        print(x);
        jsonlist.add(jsonEncode(x));
      }
      pref.setStringList('jsonstring', jsonlist);
      //
      // var obj = Transaction.fromJson(map);
      // print(obj)
    });
  }

  void delItem(int ind) async {
    transaction_details.removeAt(ind);
    final pref = await SharedPreferences.getInstance();
    List<String> jsonlist = [];
    for (var x in transaction_details) {
      print(x);
      jsonlist.add(jsonEncode(x));
    }
    setState(() {
      pref.setStringList('jsonstring', jsonlist);
    });
  }

  void show(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx) {
          return InputWidget(addItem: this.additem);
        });
  }

  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var appbar = AppBar(
      backgroundColor: Colors.purpleAccent,
      actions: [
        IconButton(
            onPressed: () {
              show(context);
            },
            icon: Icon(Icons.add)),
      ],
      title: Text('Expense Tracker'),
    );

    var listWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        transaction_details: this.transaction_details,
        del: delItem,
        h: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.6,
      ),
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///for checking and doing starting stuff in landscape mode
            if (isLandScape)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    "Show chart",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Switch(
                    value: Value,
                    onChanged: (val) {
                      setState(() {
                        //print("Came");
                        Value = val;
                      });
                    }),
              ]),

            ////
            if (isLandScape && Value)
              Text(
                "Expense chart of this week",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            if (isLandScape && Value)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                //width: double.infinity,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                    elevation: 5,
                    child: Align(
                      alignment: Alignment.center,
                      child: Chart(
                        tran: transaction_details,
                      ),
                    )),
              ),

            if (isLandScape && !Value) listWidget,
            //////////

            ///end of landscape checking and state changes

            ///not in land scape mode showing both the chart and list
            if (!isLandScape)
              Text(
                "Expense chart of this week",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            if (!isLandScape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                //width: double.infinity,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Card(
                    elevation: 5,
                    child: Align(
                      alignment: Alignment.center,
                      child: Chart(
                        tran: transaction_details,
                      ),
                    )),
              ),
            if (!isLandScape) listWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {show(context)},
      ),
    );
  }
}
