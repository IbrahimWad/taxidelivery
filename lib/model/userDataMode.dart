// To parse this JSON data, do
//
//     final uSerDataMode = uSerDataModeFromJson(jsonString);

class USerDataMode {
  String phone;

  String name;
  String? image;

  USerDataMode({
    required this.phone,
    required this.name,
    this.image,
  });

  factory USerDataMode.fromJson(Map<String, dynamic> json) => USerDataMode(
        phone: json["phone"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "name": name,
        "image": image,
      };
}
