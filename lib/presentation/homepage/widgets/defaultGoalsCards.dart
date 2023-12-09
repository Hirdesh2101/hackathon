import 'package:flutter/material.dart';
import 'package:hackathon/domain/entity/goal_entity.dart';
import 'package:hackathon/domain/entity/predefined_goal_entity.dart';
import 'package:hackathon/domain/usecases/get_predefined_goals.dart';
import 'package:hackathon/presentation/goalDetails/screens/savingGoalScreen.dart';
import 'package:provider/provider.dart';

class DefaultGoalsCards extends StatefulWidget {
  const DefaultGoalsCards({super.key});

  @override
  State<DefaultGoalsCards> createState() => _DefaultGoalsCardsState();
}

class _DefaultGoalsCardsState extends State<DefaultGoalsCards> {
  DateTime nowDate = DateTime(2023, 12, 9);

  List<PredefinedGoalEntity> defaultGoalsList = [];
  @override
  void didChangeDependencies() {
    defaultGoalsList = Provider.of<PreDefinedGoalUseCase>(context).goals;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Goals',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavingGoalsScreen(GoalEntity(
                            name: defaultGoalsList[index].name,
                            endDate: defaultGoalsList[index].endDate,
                            currentAmount: defaultGoalsList[index].currentAmount,
                            targetAmount: defaultGoalsList[index].targetAmount,
                            startDate: defaultGoalsList[index].startDate)),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 180,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: Image.network(
                          defaultGoalsList[index].imageURL!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        defaultGoalsList[index].name!,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${defaultGoalsList[index].currentAmount! * 100 ~/ defaultGoalsList[index].targetAmount!}.00% Complete',
                        style: TextStyle(
                            fontSize: 12,
                            color: (defaultGoalsList[index].currentAmount! *
                                        100 ~/
                                        defaultGoalsList[index]
                                            .targetAmount!) >=
                                    10
                                ? Colors.teal
                                : (defaultGoalsList[index].currentAmount! *
                                            100 ~/
                                            defaultGoalsList[index]
                                                .targetAmount!) ==
                                        0
                                    ? Colors.deepOrange
                                    : Colors.amber,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 15);
              },
              itemCount: defaultGoalsList.length,
            ),
          ),
        ],
      ),
    );
  }
}
