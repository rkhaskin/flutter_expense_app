import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  const TransactionList(this.transactionList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: transactionList.isEmpty
          ? Column(children: [
              Text('No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(
                  height: 200,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover)),
            ])
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                    child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      )),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                          '\$${transactionList[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                          )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transactionList[index].title,
                          // pull style from global theme headline6
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                            DateFormat.yMMMMd()
                                .format(transactionList[index].date),
                            style: const TextStyle(
                              color: Colors.grey,
                            )),
                      ],
                    )
                  ],
                ));
              },
              itemCount: transactionList.length,
            ),
    );
  }
}
