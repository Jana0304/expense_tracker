import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tansaction.dart';

class TransactionList extends StatefulWidget {
  List<Transaction> transaction_details = [];
  Function del;
  double h = 0.0;
  TransactionList(
      {required this.transaction_details, required this.del, required this.h});
  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Widget build(BuildContext context) {
    return (widget.transaction_details.isEmpty)
        ? Column(
            children: [
              Text(
                "No transactions have been added!:P",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                // height: (MediaQuery.of(context).size.height -
                //     (MediaQuery.of(context).padding.top + kToolbarHeight - 50) *
                //         0.6),
                height: widget.h - 100,
                alignment: Alignment.center,
                child: Image.asset(
                  'lib/resources/waiting.png',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: widget.transaction_details.length,
            itemBuilder: (BuildContext ctx, int ind) {
              return Card(
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.only(left: 5, top: 5, right: 3),
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(1),
                            child: FittedBox(
                              child: Text("\$ " +
                                  widget.transaction_details[ind].amount
                                      .toStringAsFixed(2)),
                            ),
                          )),
                      title: Text(
                        widget.transaction_details[ind].tranName.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(widget.transaction_details[ind].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_forever),
                        color: Colors.red,
                        onPressed: () {
                          widget.del(ind);
                        },
                      )),
                ),
              );
            },
          );
  }
}
