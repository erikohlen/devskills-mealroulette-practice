class Meal {
  final int id;
  final String title;
  final String pictureUrl;

  Meal({
    required this.id,
    required this.title,
    required this.pictureUrl,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      title: json['title'],
      pictureUrl: json['picture'],
    );
  }
}
