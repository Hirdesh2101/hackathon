import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Logo
          Image.asset(
              'assets/images/logo.png'), // replace 'assets/logo.png' with your actual logo asset path

          // Currency and Level in a Row
          Row(
            children: <Widget>[
              Icon(Icons.currency_rupee), // replace with your currency icon
              Text('10'), // your currency value
              Container(
                padding: EdgeInsets.all(4), // Adjust padding
                decoration: BoxDecoration(
                  // Adjust decoration according to your design
                  color:
                      Colors.green, // Background color of the level container
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Level 1',
                  style: TextStyle(
                    color:
                        Colors.white, // Text color inside the level container
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
