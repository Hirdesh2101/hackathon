import 'package:flutter/material.dart';
import 'package:hackathon/presentation/goalDetails/widgets/balanceCard.dart';
import 'package:hackathon/presentation/goalDetails/widgets/progressWidget.dart';

class SavingGoalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New House')),
      body: Column(
        children: [
          BalanceCard(),
          ProgressTowardsSavingGoalCard(),
          // ... more widgets for each section
        ],
      ),
    );
  }
}