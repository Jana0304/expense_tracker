import 'dart:convert';
import 'package:intl/intl.dart';

class Transaction {
  String id = "1";
  String tranName = "";
  double amount = 0;
  DateTime date = DateTime.now();

  Transaction(
      {required this.id,
      required this.tranName,
      required this.amount,
      required this.date});

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tranName = json['tranName'],
        amount = double.parse(json['amount']),
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'tranName': tranName,
        'amount': amount.toString(),
        'date': date.toString()
      };

  String toString() {
    return id +
        "  " +
        tranName +
        "   " +
        amount.toStringAsFixed(0) +
        "      " +
        DateFormat.yMMMd().format(date);
  }
}
