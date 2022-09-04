import 'package:flutter/material.dart';

import './input_widget.dart';
import './transaction_list.dart';
import '../models/tansaction.dart';

class connector extends StatelessWidget {
  List<Transaction> transaction_details = [];
  connector({required this.transaction_details});
  Widget build(BuildContext context) {
    return Column(
      children: [
        //InputWidget(addItem: this.additem),
        // TransactionList(transaction_details: this.transaction_details,del: delItem,),
      ],
    );
  }
}
