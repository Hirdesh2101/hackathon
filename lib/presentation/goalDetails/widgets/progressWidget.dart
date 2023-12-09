import 'package:flutter/material.dart';

class ProgressTowardsSavingGoalCard extends StatelessWidget {
  final double value;
  const ProgressTowardsSavingGoalCard(this.value, {super.key});

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
