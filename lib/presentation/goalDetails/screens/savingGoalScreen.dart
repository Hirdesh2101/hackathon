import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon/domain/entity/goal_entity.dart';
import 'package:hackathon/domain/usecases/goalUsecase.dart';
import 'package:hackathon/presentation/goalDetails/widgets/progressWidget.dart';
import 'package:provider/provider.dart';

class SavingGoalsScreen extends StatelessWidget {
  final GoalEntity goalEntity;

  const SavingGoalsScreen(this.goalEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          goalEntity.name!,
          style:
              const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(
                  '${goalEntity.endDate?.difference(goalEntity.startDate!).inDays} days left'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // Create a TextEditingController to retrieve the input
                          final TextEditingController textFieldController =
                              TextEditingController();
                          return AlertDialog(
                            title: const Text('Enter Investment Amount'),
                            content: TextField(
                              controller: textFieldController,
                              keyboardType: TextInputType
                                  .number, // Use number input type for keypad
                              decoration: const InputDecoration(
                                hintText: 'Enter your Amount',
                              ),
                              // The validator could also be added for form validation
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Submit'),
                                onPressed: () {
                                  final goalProvider = Provider.of<GoalUseCase>(
                                      context,
                                      listen: false);
                                  goalProvider.updateGoal(
                                      double.parse(textFieldController.text),
                                      goalEntity,
                                      context);
                                  context.go('/home');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.wallet),
                        SizedBox(height: 2),
                        Text(
                          'Invest',
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    children: [
                      Icon(Icons.remove_circle),
                      SizedBox(height: 2),
                      Text(
                        'Withdraw',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Balance',
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '₹${goalEntity.currentAmount}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Target',
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '₹${goalEntity.targetAmount}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 240,
                child: ProgressTowardsSavingGoalCard(
                    goalEntity.currentAmount! / goalEntity.targetAmount!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
