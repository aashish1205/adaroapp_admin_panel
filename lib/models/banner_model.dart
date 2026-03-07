class BannerModel {
  final String? imageUrl;
  final String? targetScreen;
  final bool active;

  BannerModel({
    this.imageUrl,
     this.targetScreen,
    required this.active,
  });

  // Convert model to Map (for Firebase / APIs)
  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'targetScreen': targetScreen,
      'active': active,
    };
  }

  // Create model from Map
  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      imageUrl: map['imageUrl'],
      targetScreen: map['targetScreen'] ?? '',
      active: map['active'] ?? false,
    );
  }
}