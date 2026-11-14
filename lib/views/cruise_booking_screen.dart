import 'package:flutter/material.dart';

import '../viewmodels/cruise_booking_viewmodel.dart';
import 'widgets/action_bar_widget.dart';
import 'widgets/booking_controls_widget.dart';
import 'widgets/description_widget.dart';
import 'widgets/header_image_widget.dart';
import 'widgets/title_section_widget.dart';

/// VIEW layer: assembles the sub-widgets and adapts to orientation.
class CruiseBookingScreen extends StatelessWidget {
  const CruiseBookingScreen({super.key, required this.viewModel});

  final CruiseBookingViewModel viewModel;

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sibu River Cruise & Heritage'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      // Rebuild whenever the ViewModel calls notifyListeners()
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.portrait
                  ? _buildPortrait(context)
                  : _buildLandscape(context);
            },
          );
        },
      ),
    );
  }

  // ---- Shared detail widgets (title, actions, description, controls) ----
  List<Widget> _detailWidgets(BuildContext context, {String? descTitle}) {
    final dest = viewModel.destination;
    return [
      TitleSectionWidget(
        name: dest.name,
        location: dest.location,
        starCount: viewModel.starCount,
        isStarred: viewModel.isStarred,
        onStarTap: viewModel.toggleStar,
      ),
      const Divider(height: 1),
      ActionBarWidget(
        onCall: () => _showMessage(context, 'Calling Sibu Municipal Council...'),
        onRoute: () => _showMessage(context, 'Opening route to Sibu Waterfront...'),
        onShare: () => _showMessage(context, 'Sharing ${dest.name}...'),
      ),
      const Divider(height: 1),
      DescriptionWidget(text: dest.description, title: descTitle),
      BookingControlsWidget(viewModel: viewModel),
    ];
  }

  // ---- Portrait: single scrolling column ----
  Widget _buildPortrait(BuildContext context) {
    final dest = viewModel.destination;
    return ListView(
      children: [
        HeaderImageWidget(
          imageSource: dest.imageSource,
          caption: dest.imageCaption,
          height: 220,
        ),
        ..._detailWidgets(context),
      ],
    );
  }

  // ---- Landscape: image on the left, scrollable details on the right ----
  Widget _buildLandscape(BuildContext context) {
    final dest = viewModel.destination;
    return Row(
      children: [
        Expanded(
          child: HeaderImageWidget(
            imageSource: dest.imageSource,
            caption: dest.imageCaption,
          ),
        ),
        Expanded(
          child: ListView(
            children: _detailWidgets(context, descTitle: 'About the Destination'),
          ),
        ),
      ],
    );
  }
}