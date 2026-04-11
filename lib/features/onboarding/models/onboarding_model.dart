class OnboardingModel {
  final String title;
  final String description;
  final String image;
  final String tag;
  final String? statusLabel;
  final String? statusValue;

  const OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
    required this.tag,
    this.statusLabel,
    this.statusValue,
  });
}
