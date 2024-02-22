class Getofferproducts {
  int id;
  int catid;
  String productname;
  double price;
  String image;
  String description;

  Getofferproducts({
    required this.id,
    required this.catid,
    required this.productname,
    required this.price,
    required this.image,
    required this.description,
  });

  factory Getofferproducts.fromJson(Map<String, dynamic> json) =>
      Getofferproducts(
        id: json["id"],
        catid: json["catid"],
        productname: json["productname"],
        price: json["price"]?.toDouble(),
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "catid": catid,
        "productname": productname,
        "price": price,
        "image": image,
        "description": description,
      };
}
