class RecipeModel {
  final String name;
  final String author;
  final String imageLink;
  final List<String> recipeSteps;

  RecipeModel({
    required this.name,
    required this.author,
    required this.imageLink,
    required this.recipeSteps,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
        name: json["name"],
        author: json["author"],
        imageLink: json["image_link"],
        recipeSteps: List<String>.from(json["recipe"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "author": author,
      "image_link": imageLink,
      "recipe": recipeSteps
    };
  }

  @override
  String toString() {
    return "Recipe{name: $name, author: $author, image_link: $imageLink, recipe: $recipeSteps}";
  }
}
