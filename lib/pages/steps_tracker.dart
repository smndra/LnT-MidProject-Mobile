import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fitness_provider.dart';

class StepsTrackerScreen extends StatefulWidget {
  @override
  _StepsTrackerScreenState createState() => _StepsTrackerScreenState();
}

class _StepsTrackerScreenState extends State<StepsTrackerScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();

  String _getStatus(int steps) {
    if (steps < 4000) return "Bad ❌";
    if (steps >= 4000 && steps <= 8000) return "Average ⚠️";
    return "Good ✅";
  }

  void _addOrUpdateSteps(BuildContext context) {
    String date = _dateController.text.trim();
    int steps = int.tryParse(_stepsController.text) ?? 0;

    if (date.isNotEmpty && steps > 0) {
      Provider.of<FitnessProvider>(context, listen: false).addSteps(date, steps);
      _dateController.clear();
      _stepsController.clear();
    }
  }

  void _deleteSteps(BuildContext context, String date) {
    Provider.of<FitnessProvider>(context, listen: false).removeSteps(date);
  }

  @override
  Widget build(BuildContext context) {
    final stepsData = Provider.of<FitnessProvider>(context).stepsData;

    return Scaffold(
      appBar: AppBar(title: Text("Steps Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: "Enter Date (YYYY-MM-DD)"),
            ),
            TextField(
              controller: _stepsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter Steps"),
            ),
            ElevatedButton(
              onPressed: () => _addOrUpdateSteps(context),
              child: Text("Save Steps"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: stepsData.length,
                itemBuilder: (context, index) {
                  String date = stepsData.keys.elementAt(index);
                  int steps = stepsData[date]!;
                  String status = _getStatus(steps);

                  return ListTile(
                    title: Text("Date: $date"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Steps: $steps steps"),
                        Text("Status: $status", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _dateController.text = date;
                            _stepsController.text = steps.toString();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteSteps(context, date),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
