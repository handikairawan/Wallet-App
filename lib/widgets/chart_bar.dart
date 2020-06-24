import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount, spendingPercent;

  ChartBar(this.label, this.spendingAmount, this.spendingPercent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) {
        //layout builder to set constraints height of tree widget
        return Column(
          children: <Widget>[
            Container(
                height: Constraints.maxHeight * 0.15,
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
            SizedBox(
              height: Constraints.maxHeight * 0.05,
            ),
            Container(
              height:
                  Constraints.maxHeight * 0.6, //set height to 60% of max height
              width: 15,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal, width: 2),
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Constraints.maxHeight * 0.05,
            ),
            Container(
                height: Constraints.maxHeight * 0.15,
                child: FittedBox(fit: BoxFit.scaleDown, child: Text(label))),
          ],
        );
      },
    );
  }
}
