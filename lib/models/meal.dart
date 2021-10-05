class Meal {
  final int id;
  final String title;
  final String picture;
  String? description;
  List<String>? ingredients;

  Meal({
    required this.id,
    required this.title,
    required this.picture,
    this.description,
    this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      title: json['title'],
      picture: json['picture'],
      description: json['description'] ?? '',
      ingredients: json['ingredients'] ?? [],
    );
  }
}
