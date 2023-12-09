import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon/data/models/goal_model.dart';
import 'package:hackathon/domain/entity/goal_entity.dart';
import 'package:hackathon/domain/usecases/goalUsecase.dart';
import 'package:hackathon/domain/usecases/userUsecase.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(),
                    Text(
                      'Enter Details',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close,
                          color: Colors.white), // Change color as needed
                      onPressed: () =>
                          Navigator.pop(context), // Dismiss the modal sheet
                    ),
                  ],
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Goal Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your goal name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Target Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the target amount';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                ListTile(
                  title: Text(
                      'Start Date: ${DateFormat('yyyy-MM-dd').format(_startDate)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () {
                    _selectDate(context, true);
                  },
                ),
                ListTile(
                  title: Text(
                      'End Date: ${DateFormat('yyyy-MM-dd').format(_endDate)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () {
                    _selectDate(context, false);
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // Check if end date is at least a month after start date
                      final DateTime oneMonthAfterStart =
                          _startDate.add(Duration(days: 30));
                      if (_endDate.isBefore(oneMonthAfterStart)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'End date should be at least a month after the start date.')),
                        );
                      } else {
                        GoalModel newGoal = GoalModel(
                            name: _nameController.text.trim(),
                            targetAmount:
                                double.parse(_amountController.text.trim()),
                            startDate: _startDate,
                            endDate: _endDate,
                            reachedMilestones: [],
                            currentAmount: 0);
                        final goalProvider =
                            Provider.of<GoalUseCase>(context, listen: false);
                        goalProvider.addGoal(newGoal);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Successfully added a new Goal.')),
                        );
                        context.pop();
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
