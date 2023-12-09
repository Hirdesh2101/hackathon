import 'package:flutter/material.dart';
import 'package:hackathon/domain/usecases/userUsecase.dart';
import 'package:hackathon/presentation/homepage/widgets/customAppBar.dart';
import 'package:hackathon/presentation/homepage/widgets/goalsListCard.dart';
import 'package:hackathon/presentation/homepage/widgets/portfolioValueCard.dart';
import 'package:provider/provider.dart';

class PortfolioOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserUseCase>(context).user;
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Currency and Level in a Row
            Container(
                padding: EdgeInsets.all(4), // Adjust padding
                decoration: BoxDecoration(
                  // Adjust decoration according to your design
                  color:
                      Colors.green, // Background color of the level container
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/game-token.png',
                      fit: BoxFit.contain,
                      height: 25,
                      width: 25,
                    ),
                    Text(user.coins.toString()),
                  ],
                )),
          ],
        ),
      ),

      //  AppBar(
      //   iconTheme: const IconThemeData(color: Colors.black),
      //   leading: CircleAvatar(
      //     child: Image.asset(
      //       'assets/images/logo.png',
      //       fit: BoxFit.contain,
      //     ),
      //   ),
      //   actions: [
      //     Container(child: Row(children: [

      //     ]),)
      //   ],
      // ),

      body: Column(
        children: [
          PortfolioValueCard(),
          GoalsListCard(),
        ],
      ),
    );
  }
}
