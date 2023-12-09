import 'package:flutter/material.dart';

class ProgressTowardsSavingGoalCard extends StatelessWidget {
  final double value;
  ProgressTowardsSavingGoalCard(this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          LinearProgressIndicator(value: value),
        ],
      ),
    );
  }
}
