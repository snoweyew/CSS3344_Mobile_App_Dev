import 'package:flutter/material.dart';

import '../../viewmodels/cruise_booking_viewmodel.dart';

/// PreferenceSection: date picker tile, package dropdown, dark-mode switch.
/// All values are read from / written to the ViewModel.
class BookingControlsWidget extends StatelessWidget {
  const BookingControlsWidget({super.key, required this.viewModel});

  final CruiseBookingViewModel viewModel;

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final initial =
    viewModel.selectedDate.isBefore(today) ? today : viewModel.selectedDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
      helpText: 'Select cruise date',
    );

    if (picked != null) {
      viewModel.setDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Text(
                  'Trip Preferences',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              // 1) Visit date picker
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Cruise Date'),
                trailing: Text(
                  viewModel.formattedDate,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () => _pickDate(context),
              ),

              // 2) Cruise package dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.directions_boat, color: Colors.grey),
                    const SizedBox(width: 16),
                    const Text('Package'),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButton<String>(
                        value: viewModel.selectedPackage,
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        items: viewModel.packages
                            .map((p) => DropdownMenuItem<String>(
                          value: p,
                          child: Text(p, overflow: TextOverflow.ellipsis),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) viewModel.setPackage(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // 3) Dark mode switch
              SwitchListTile(
                secondary: Icon(
                  viewModel.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                title: const Text('Dark Mode'),
                value: viewModel.isDarkMode,
                onChanged: viewModel.setDarkMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}