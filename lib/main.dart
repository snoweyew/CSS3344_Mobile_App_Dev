import 'package:flutter/material.dart';

import 'viewmodels/cruise_booking_viewmodel.dart';
import 'views/cruise_booking_screen.dart';

void main() {
  runApp(const RajangCruiseApp());
}

class RajangCruiseApp extends StatefulWidget {
  const RajangCruiseApp({super.key});

  @override
  State<RajangCruiseApp> createState() => _RajangCruiseAppState();
}

class _RajangCruiseAppState extends State<RajangCruiseApp> {
  // Created once and owned by this State so it survives rebuilds/rotation.
  late final CruiseBookingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CruiseBookingViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild MaterialApp when the theme switch changes.
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return MaterialApp(
          title: 'Rajang River Cruise',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF4F46E5),
            ),
          ),
          darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF4F46E5),
              brightness: Brightness.dark,
            ),
          ),
          themeMode: _viewModel.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: CruiseBookingScreen(viewModel: _viewModel),
        );
      },
    );
  }
}