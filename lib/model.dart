import 'dart:convert';

List<Temperatures> temperaturesFromJson(String str) => List<Temperatures>.from(
    json.decode(str).map((x) => Temperatures.fromJson(x)));

String temperaturesToJson(List<Temperatures> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Temperatures {
  Temperatures({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  int userId;
  int id;
  String title;
  bool completed;

  factory Temperatures.fromJson(Map<String, dynamic> json) => Temperatures(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
