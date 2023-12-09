import 'package:flutter/material.dart';
import 'package:hackathon/domain/usecases/goalUsecase.dart';
import 'package:hackathon/presentation/goalDetails/screens/savingGoalScreen.dart';
import 'package:provider/provider.dart';

class GoalsListCard extends StatelessWidget {
  const GoalsListCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Build a card for Goals list
    var goals = Provider.of<GoalUseCase>(context).goals;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Savings',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        //TODO handle empty
        if (goals.isEmpty)
          const Center(child: Padding(
            padding:  EdgeInsets.only(top:8.0),
            child: Text('No Savings yet Start investing today!'),
          )),
        ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: goals.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavingGoalsScreen(goals[index]),
                      ),
                    );
                },
                child: ListTile(
                  leading: const Icon(Icons.savings),
                  title: Text(goals[index].name ?? ''),
                  subtitle: Text(
                      '${goals[index].currentAmount} out of ${goals[index].targetAmount}'),
                ),
              );
            }),
      ],
    );
  }
}
