class Attraction {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String location;
  final double rating;
  final String historicalInfo;
  final String culturalInfo;
  final List<String> galleryImages;

  Attraction({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.rating,
    required this.historicalInfo,
    required this.culturalInfo,
    required this.galleryImages,
  });
}