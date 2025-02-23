import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/steps_tracker.dart';
import 'pages/water_intake.dart';
import 'providers/fitness_provider.dart'; 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FitnessProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fitness Tracker")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text("Steps Tracker"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StepsTrackerScreen()),
                );
              },
            ),
            ListTile(
              title: Text("Water Intake Tracker"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WaterIntakeScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Consumer<FitnessProvider>(
        builder: (context, provider, child) {
          String latestStepsDate = provider.stepsData.keys.isNotEmpty
              ? provider.stepsData.keys.last
              : "No Data";
          int latestSteps = provider.stepsData.isNotEmpty
              ? provider.stepsData[latestStepsDate] ?? 0
              : 0;

          String latestWaterDate = provider.waterData.keys.isNotEmpty
              ? provider.waterData.keys.last
              : "No Data";
          double latestWater = provider.waterData.isNotEmpty
              ? provider.waterData[latestWaterDate] ?? 0.0
              : 0.0;

          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fitness Summary",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text("Latest Steps"),
                      subtitle: Text("Date: $latestStepsDate\nSteps: $latestSteps"),
                      leading: Icon(Icons.directions_walk, color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text("Latest Water Intake"),
                      subtitle: Text("Date: $latestWaterDate\nWater: $latestWater L"),
                      leading: Icon(Icons.local_drink, color: Colors.blue),
                    ),
                  ),
                ]
              )
            )
          );
        }
      )
    );
  }
}