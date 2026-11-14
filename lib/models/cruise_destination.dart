/// MODEL layer: pure data class, no Flutter imports, no UI logic.
class CruiseDestination {
  final String name;
  final String location;
  final String description;
  final String imageSource; // asset path or http(s) URL
  final String imageCaption;
  final int initialStarCount;
  final List<String> packages;

  const CruiseDestination({
    required this.name,
    required this.location,
    required this.description,
    required this.imageSource,
    required this.imageCaption,
    required this.initialStarCount,
    required this.packages,
  });

  /// Sample data used by the lab.
  static const CruiseDestination rajangRiver = CruiseDestination(
    name: 'Rajang River Express Cruise',
    location: 'Sibu Waterfront, Sarawak',
    description:
    'Experience the heart of Sibu along Malaysia\'s longest river, the '
        'Rajang. Cruise past historic temples, timber hubs, and traditional '
        'waterfront settlements while experiencing authentic Sarawakian '
        'hospitality.',
    // Put your own image at this path (and register it in pubspec.yaml),
    // or replace it with an https:// image URL.
    imageSource: 'assets/images/rajang_river.jpg',
    imageCaption: 'Sibu Esplanade Landmark',
    initialStarCount: 42,
    packages: [
      'Private River Cruise',
      'Sunset Cruise',
      'Sunrise Cruise',
      'Rural Cruise',
      'SMI Park Cruise',
    ],
  );
}