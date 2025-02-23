// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'pages/steps_tracker.dart';
// import 'pages/water_intake.dart';
// import 'providers/fitness_provider.dart'; 

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => FitnessProvider(),
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Fitness Tracker")),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(color: Colors.blue),
//               child: Text(
//                 'Menu',
//                 style: TextStyle(color: Colors.white, fontSize: 24),
//               ),
//             ),
//             ListTile(
//               title: Text("Steps Tracker"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => StepsTrackerScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text("Water Intake Tracker"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => WaterIntakeScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: Text("Welcome to Fitness Tracker! Use the menu to navigate."),
//       ),
//     );
//   }
// }