import 'package:flutter/material.dart';
import 'package:hackathon/domain/usecases/userUsecase.dart';
import 'package:provider/provider.dart';

class RedeemScreen extends StatelessWidget {
  const RedeemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserUseCase>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scratch Cards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Action for help button
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20), // Spacing
            const Text(
              'Reward Balance',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10), // Spacing
            Text(
              '₹ ${user.coins}',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Spacing
            ElevatedButton(
              onPressed: () {
                // Action for redeem button
              },
              child: const Text('REDEEM'),
            ),
            const SizedBox(height: 10), // Spacing
            const Text(
              'Reward Balance can be redeemed on reaching ₹200',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
