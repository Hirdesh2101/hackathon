import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text('Balance'),
          Text('10,00,000'),
          Text('Target'),
          Text('20,00,000'),
          Text('Based on your activity and weekly deposit...'),
          // ... more details
        ],
      ),
    );
  }
}