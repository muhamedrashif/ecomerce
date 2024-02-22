class Getuser {
  String name;
  String phone;
  String address;
  String username;

  Getuser({
    required this.name,
    required this.phone,
    required this.address,
    required this.username,
  });

  factory Getuser.fromJson(Map<String, dynamic> json) => Getuser(
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        username: json["username"],
      );
}
