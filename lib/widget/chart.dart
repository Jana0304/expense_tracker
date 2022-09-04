import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import '../models/tansaction.dart';

class Chart extends StatelessWidget {
  List<Container> list = [];
  List<Transaction> tran;
  Chart({required this.tran});
  List<Container> widgetslist() {
    for (int i = 6; i >= 0; i--) {
      var weekdays = (DateTime.now()).subtract(Duration(days: i));
      var amount = 0.0;
      for (int j = 0; j < tran.length; j++) {
        if (DateFormat.yMMMMEEEEd().format(tran[j].date) ==
            DateFormat.yMMMMEEEEd().format(weekdays)) {
          amount += tran[j].amount;
        }
      }

      list.add(Container(
          child: Flexible(
              fit: FlexFit.tight,
              child: columnData(
                DateFormat.E().format(weekdays),
                amount,
                i,
              ))));
    }
    return list;
  }

  double totalamount() {
    double amt = 0.0;
    for (int j = 0; j < tran.length; j++) amt += tran[j].amount;
    return amt;
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgetslist(),
      ),
    );
  }

  Container columnData(String week, double amount, int i) {
    double tot = totalamount();
    //print("$i ${}");
    var per = (tot == 0) ? 0 : (amount / tot) * 100;
    //double per = (amount / tot) * 100;print(per);
    return Container(
      child: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  "\$" + amount.toStringAsFixed(0),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 15,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                        ),
                        color: Colors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  FractionallySizedBox(
                    heightFactor: (100 - per) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple,
                          ),
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  week,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
