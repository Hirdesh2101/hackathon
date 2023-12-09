import 'package:flutter/material.dart';
import 'package:hackathon/domain/usecases/userUsecase.dart';
import 'package:hackathon/presentation/homepage/widgets/formWidget.dart';
import 'package:provider/provider.dart';

class PortfolioValueCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserUseCase>(context).user;
    return Card(
      color: Color(0xFF1E1E1E),
      child: Column(
        children: [
          SizedBox(height: 20), // Spacing between elements
          Text(
            'Hi ${user.name}',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'Welcome to Fello Hackathon',
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
          SizedBox(height: 20), // Spacing between elements
          // Balance card
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Fello Balance',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '₹${user.totalInvesed}',
                      style: TextStyle(
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
                          return MyCustomForm();
                        });
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          // Investment options list
          SizedBox(
            height: 200,
            child: ListView(
              children: <Widget>[
                InvestmentOptionCard(
                  title: 'Invest in',
                  subtitle: 'Gold & 12% P2P',
                  color: Color(0xFFDAA520), // Gold color
                ),
                InvestmentOptionCard(
                  title: 'Know about',
                  subtitle: 'Digital Gold',
                  color: Color(0xFF4A4A4A), // Grey color
                ),
                //Add more cards as needed
              ],
            ),
          ),
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
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title!,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          subtitle!,
          style: TextStyle(color: Colors.white70),
        ),
        // Add trailing or leading icons if needed
      ),
    );
  }
}
