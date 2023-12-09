import 'package:flutter/material.dart';
import 'package:hackathon/domain/usecases/userUsecase.dart';
import 'package:provider/provider.dart';

class RedeemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserUseCase>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch Cards'),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Action for help button
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20), // Spacing
            Text(
              'Reward Balance',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10), // Spacing
            Text(
              '₹ ${user.coins}',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Spacing
            ElevatedButton(
              onPressed: () {
                // Action for redeem button
              },
              child: Text('REDEEM'),
            ),
            SizedBox(height: 10), // Spacing
            Text(
              'Reward Balance can be redeemed on reaching ₹200',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
