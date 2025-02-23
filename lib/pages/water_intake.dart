import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fitness_provider.dart';

class WaterIntakeScreen extends StatefulWidget {
  @override
  _WaterIntakeScreenState createState() => _WaterIntakeScreenState();
}

class _WaterIntakeScreenState extends State<WaterIntakeScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();

  String _getStatus(double liters) {
    if (liters < 1.5) return "Bad ❌";
    if (liters >= 1.5 && liters <= 2) return "Average ⚠️";
    return "Good ✅";
  }

  void _addOrUpdateWater(BuildContext context) {
    String date = _dateController.text.trim();
    double liters = double.tryParse(_waterController.text) ?? 0;

    if (date.isNotEmpty && liters > 0) {
      Provider.of<FitnessProvider>(context, listen: false).addWater(date, liters);
      _dateController.clear();
      _waterController.clear();
    }
  }

  void _deleteWater(BuildContext context, String date) {
    Provider.of<FitnessProvider>(context, listen: false).removeWater(date);
  }

  @override
  Widget build(BuildContext context) {
    final waterData = Provider.of<FitnessProvider>(context).waterData;

    return Scaffold(
      appBar: AppBar(title: Text("Water Intake Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: "Enter Date (YYYY-MM-DD)"),
            ),
            TextField(
              controller: _waterController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Enter Water Intake (L)"),
            ),
            ElevatedButton(
              onPressed: () => _addOrUpdateWater(context),
              child: Text("Save Water Intake"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: waterData.length,
                itemBuilder: (context, index) {
                  String date = waterData.keys.elementAt(index);
                  double liters = waterData[date]!;
                  String status = _getStatus(liters); // Menentukan status

                  return ListTile(
                    title: Text("Date: $date"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Water Intake: $liters L"),
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
                            _waterController.text = liters.toString();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteWater(context, date),
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
