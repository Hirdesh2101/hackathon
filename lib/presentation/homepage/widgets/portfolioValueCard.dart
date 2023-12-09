import 'package:flutter/material.dart';
import 'package:hackathon/domain/usecases/userUsecase.dart';
import 'package:hackathon/presentation/homepage/widgets/defaultGoalsCards.dart';
import 'package:hackathon/presentation/homepage/widgets/formWidget.dart';
import 'package:provider/provider.dart';

class PortfolioValueCard extends StatelessWidget {
  const PortfolioValueCard({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserUseCase>(context).user;
    return Card(
      color: const Color(0xFF1E1E1E),
      child: Column(
        children: [
          const SizedBox(height: 20), // Spacing between elements
          Text(
            'Hi ${user.name}',
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Welcome to Fello Hackathon',
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const SizedBox(height: 20), // Spacing between elements
          // Balance card
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Fello Balance',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '₹${user.totalInvesed}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    // Add more widgets as needed
                  ],
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10)),
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return const MyCustomForm();
                        });
                  },
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          // Investment options list
          const DefaultGoalsCards(),
        ],
      ),
    );
  }
}

class InvestmentOptionCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? color;

  const InvestmentOptionCard({
    Key? key,
    this.title,
    this.subtitle,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title!,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          subtitle!,
          style: const TextStyle(color: Colors.white70),
        ),
        // Add trailing or leading icons if needed
      ),
    );
  }
}
