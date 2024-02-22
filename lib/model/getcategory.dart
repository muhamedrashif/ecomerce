class Getcategory {
  int id;
  String category;

  Getcategory({
    required this.id,
    required this.category,
  });

  factory Getcategory.fromJson(Map<String, dynamic> json) => Getcategory(
        id: json["id"],
        category: json["category"],
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "category": category,
  //     };
}
