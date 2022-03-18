import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$label $spendingAmount $spendingPctOfTotal');
    return Column(
      children: [
        FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(2)}')),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 50,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                color: const Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ))
          ]),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
