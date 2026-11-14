import 'package:flutter/foundation.dart';

import '../models/cruise_destination.dart';

/// VIEWMODEL layer: holds app state + business logic.
/// The View listens to it (via ListenableBuilder) and rebuilds on notifyListeners().
class CruiseBookingViewModel extends ChangeNotifier {
  CruiseBookingViewModel({this.destination = CruiseDestination.rajangRiver}) {
    _starCount = destination.initialStarCount;
    _selectedPackage = destination.packages.first;
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day)
        .add(const Duration(days: 1));
  }

  final CruiseDestination destination;

  late int _starCount;
  late String _selectedPackage;
  late DateTime _selectedDate;
  bool _isStarred = false;
  bool _isDarkMode = false;

  // ---- Getters (read-only state for the View) ----
  int get starCount => _starCount;
  bool get isStarred => _isStarred;
  String get selectedPackage => _selectedPackage;
  DateTime get selectedDate => _selectedDate;
  bool get isDarkMode => _isDarkMode;
  List<String> get packages => destination.packages;

  /// dd/MM/yyyy (no intl package needed)
  String get formattedDate {
    final d = _selectedDate.day.toString().padLeft(2, '0');
    final m = _selectedDate.month.toString().padLeft(2, '0');
    return '$d/$m/${_selectedDate.year}';
  }

  // ---- Actions (called by the View) ----
  /// Tap the star: +1 on first tap, back to original on second tap.
  void toggleStar() {
    _isStarred = !_isStarred;
    _starCount += _isStarred ? 1 : -1;
    notifyListeners();
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setPackage(String value) {
    if (value == _selectedPackage) return;
    _selectedPackage = value;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}