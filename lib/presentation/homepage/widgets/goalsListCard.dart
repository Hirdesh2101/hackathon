import 'package:flutter/material.dart';
import 'package:hackathon/domain/usecases/goalUsecase.dart';
import 'package:provider/provider.dart';

class GoalsListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Build a card for Goals list
    var goals = Provider.of<GoalUseCase>(context).goals;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Savings',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        //TODO handle empty
        ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: goals.length,
            itemBuilder: (context, index) {

              return ListTile(
                leading: Icon(Icons.savings),
                title: Text(goals[index].name ?? ''),
                subtitle: Text(
                    '${goals[index].currentAmount} out of ${goals[index].targetAmount}'),
              );
            }),
      ],
    );
  }
}
